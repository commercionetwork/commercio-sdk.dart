import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document.g.dart';

/// Commercio network's did document is described here:
/// https://scw-gitlab.zotsell.com/Commercio.network/Cosmos-application/blob/master/Commercio%20Decentralized%20ID%20framework.md
@JsonSerializable(explicitToJson: true)
class DidDocument extends Equatable {
  @JsonKey(name: '@context')
  final String context;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'publicKey')
  final List<DidDocumentPublicKey> publicKeys;

  @JsonKey(name: 'proof')
  final DidDocumentProof proof;

  @JsonKey(name: 'service', includeIfNull: false)
  final List<DidDocumentService>? service;

  const DidDocument({
    required this.context,
    required this.id,
    required this.publicKeys,
    required this.proof,
    this.service,
  });

  @override
  List<Object?> get props {
    return [context, id, publicKeys, proof, service];
  }

  /// Returns the [PublicKey] that should be used as the public encryption
  /// key when encrypting data that can later be read only by the owner of
  /// this Did Document.
  RSAPublicKey? get encryptionKey {
    final pubKey = publicKeys
        .firstWhereOrNull((key) => key.type == 'RsaVerificationKey2018');
    if (pubKey == null) return null;

    return RSAPublicKey(
      RSAKeyParser.parseKeyFromPem(pubKey.publicKeyPem),
    );
  }

  factory DidDocument.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentToJson(this);
}

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
