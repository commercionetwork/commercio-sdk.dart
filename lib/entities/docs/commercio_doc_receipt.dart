import 'package:commerciosdk/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'commercio_doc_receipt.g.dart';

/// Represents a document receipt that indicates that the document having
/// the given [documentUuid] present inside the transaction with has [txHash]
/// and sent by [recipientDid] has been received from the [senderDid].
@JsonSerializable(includeIfNull: false)
class CommercioDocReceipt extends Equatable {
  /// Unique receipt identifier.
  @JsonKey(name: 'uuid')
  final String uuid;

  /// Must be one of the recipients of the shared document.
  @JsonKey(name: 'sender')
  final String senderDid;

  /// The sender of the document.
  @JsonKey(name: 'recipient')
  final String recipientDid;

  /// Transaction hash in which the document has been sent.
  @JsonKey(name: 'tx_hash')
  final String txHash;

  /// The shared document unique identifier.
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
    this.proof,
  })  : assert(uuid != null && matchUuidv4(uuid)),
        assert(senderDid != null && matchBech32Format(senderDid)),
        assert(recipientDid != null && matchBech32Format(recipientDid)),
        assert(txHash != null),
        assert(documentUuid != null && matchUuidv4(documentUuid));

  @override
  List<Object> get props {
    return [uuid, senderDid, recipientDid, txHash, documentUuid, proof];
  }

  factory CommercioDocReceipt.fromJson(Map<String, dynamic> json) =>
      _$CommercioDocReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$CommercioDocReceiptToJson(this);
}
