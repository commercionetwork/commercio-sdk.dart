import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'commercio_doc_receipt.g.dart';

/// Represents a document receipt that indicates that the document having
/// the given [documentUuid] present inside the transaction with has [txHash]
/// and sent by [recipientDid] has been received from the [senderDid].
@JsonSerializable()
class CommercioDocReceipt extends Equatable {
  @JsonKey(name: 'uuid')
  final String uuid;

  @JsonKey(name: 'sender')
  final String senderDid;

  @JsonKey(name: 'recipient')
  final String recipientDid;

  @JsonKey(name: 'tx_hash')
  final String txHash;

  @JsonKey(name: 'document_uuid')
  final String documentUuid;

  /// Optional reading proof
  @JsonKey(name: 'proof')
  final String proof;

  CommercioDocReceipt({
    @required this.uuid,
    @required this.senderDid,
    @required this.recipientDid,
    @required this.txHash,
    @required this.documentUuid,
    this.proof = '',
  })  : assert(uuid != null),
        assert(senderDid != null),
        assert(recipientDid != null),
        assert(txHash != null),
        assert(documentUuid != null),
        assert(proof != null);

  @override
  List<Object> get props {
    return [senderDid, recipientDid, txHash, documentUuid, proof];
  }

  factory CommercioDocReceipt.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocReceiptToJson(this);
}
