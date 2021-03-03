import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'did_document_public_key.g.dart';

/// Contains the data of public key contained inside a Did document.'
@JsonSerializable(explicitToJson: true)
class DidDocumentPublicKey extends Equatable {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'controller')
  final String controller;

  @JsonKey(name: 'publicKeyPem')
  final String publicKeyPem;

  const DidDocumentPublicKey({
    required this.id,
    required this.type,
    required this.controller,
    required this.publicKeyPem,
  });

  @override
  List<Object> get props {
    return [id, type, controller, publicKeyPem];
  }

  factory DidDocumentPublicKey.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentPublicKeyFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentPublicKeyToJson(this);
}

enum DidDocumentPubKeyType {
  @JsonValue('RsaVerificationKey2018')
  RSA,
  @JsonValue('Ed25519VerificationKey2018')
  ED25519,
  @JsonValue('Secp256k1VerificationKey2018')
  SECP256K1,
}
