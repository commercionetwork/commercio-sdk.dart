// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercio_doc_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommercioDocReceipt _$CommercioDocReceiptFromJson(Map<String, dynamic> json) {
  return CommercioDocReceipt(
    uuid: json['uuid'] as String,
    senderDid: json['sender'] as String,
    recipientDid: json['recipient'] as String,
    txHash: json['tx_hash'] as String,
    documentUuid: json['document_uuid'] as String,
    proof: json['proof'] as String,
  );
}

Map<String, dynamic> _$CommercioDocReceiptToJson(
        CommercioDocReceipt instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'sender': instance.senderDid,
      'recipient': instance.recipientDid,
      'tx_hash': instance.txHash,
      'document_uuid': instance.documentUuid,
      'proof': instance.proof,
    };
