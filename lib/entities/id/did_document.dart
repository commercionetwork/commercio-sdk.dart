import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/export.dart' as pointy_castle;

part 'did_document.g.dart';

/// Commercio network's did document is described here:
/// https://scw-gitlab.zotsell.com/Commercio.network/Cosmos-application/blob/master/Commercio%20Decentralized%20ID%20framework.md
@JsonSerializable(explicitToJson: true)
class DidDocument extends Equatable {
  @JsonKey(name: "@context")
  final String context;

  @JsonKey(name: "id")
  final String id;

  @JsonKey(name: "publicKey")
  final List<DidDocumentPublicKey> publicKeys;

  @JsonKey(name: "proof")
  final DidDocumentProof proof;

  @JsonKey(name: "service")
  final List<DidDocumentService> services;

  DidDocument({
    @required this.context,
    @required this.id,
    @required this.publicKeys,
    @required this.proof,
    this.services,
  })  : assert(context != null),
        assert(id != null),
        assert(publicKeys != null),
        assert(proof != null);

  @override
  List<Object> get props {
    return [context, id, publicKeys, proof, services];
  }

  /// Returns the [PublicKey] that should be used as the public encryption
  /// key when encrypting data that can later be read only by the owner of
  /// this Did Document.
  RSAPublicKey get encryptionKey {
    final pubKey = publicKeys.firstWhere(
      (key) => key.type == DidDocumentPubKeyType.RSA,
      orElse: () => null,
    );
    if (pubKey == null) return null;

    final modulus = BigInt.parse(pubKey.publicKeyPem, radix: 16);
    final exponent = BigInt.from(65537);
    return RSAPublicKey(pointy_castle.RSAPublicKey(modulus, exponent));
  }

  factory DidDocument.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentToJson(this);
}
