import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document_public_key.g.dart';

/// Contains the data of public key contained inside a Did document.'
@JsonSerializable(explicitToJson: true)
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

enum DidDocumentPubKeyType {
  @JsonValue("RsaVerificationKey2018")
  RSA,
  @JsonValue("Ed25519VerificationKey2018")
  ED25519,
  @JsonValue("Secp256k1VerificationKey2018")
  SECP256K1,
}
