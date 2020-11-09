import 'package:commerciosdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document_proof_signature_content.g.dart';

@JsonSerializable()
class DidDocumentProofSignatureContent extends Equatable {
  @JsonKey(name: '@context')
  final String context;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'publicKey')
  final List<DidDocumentPublicKey> publicKeys;

  DidDocumentProofSignatureContent({
    @required this.context,
    @required this.id,
    @required this.publicKeys,
  })  : assert(context != null),
        assert(id != null),
        assert(publicKeys != null);

  @override
  List<Object> get props {
    return [context, id, publicKeys];
  }

  factory DidDocumentProofSignatureContent.fromJson(
          Map<String, dynamic> json) =>
      _$DidDocumentProofSignatureContentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DidDocumentProofSignatureContentToJson(this);
}
