import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document_public_key.g.dart';

/// Contains the data of public key contained inside a Did document.'
@JsonSerializable(includeIfNull: false)
class DidDocumentPublicKey extends Equatable {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "type")
  final DidDocumentPubKeyType type;
  @JsonKey(name: "controller")
  final String controller;
  @JsonKey(name: "publicKeyHex")
  final String publicKeyHex;

  DidDocumentPublicKey({
    @required this.id,
    @required this.type,
    @required this.controller,
    @required this.publicKeyHex,
  })  : assert(id != null),
        assert(type != null),
        assert(controller != null),
        assert(publicKeyHex != null),
        super([id, type, controller, publicKeyHex]);

  factory DidDocumentPublicKey.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentPublicKeyFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentPublicKeyToJson(this);
}

/// Returns true iff the given [pubKeyType] is a valid public key type.
bool validateType(String pubKeyType) {
  var type = pubKeyType.toLowerCase();
  return type == DidDocumentPubKeyType.RSA ||
      type == DidDocumentPubKeyType.ED25519 ||
      type == DidDocumentPubKeyType.SECP256K1;
}

enum DidDocumentPubKeyType {
  @JsonKey(name: "RsaVerificationKey2018")
  RSA,
  @JsonKey(name: "Ed25519VerificationKey2018")
  ED25519,
  @JsonKey(name: "Secp256k1VerificationKey2018")
  SECP256K1,
}
