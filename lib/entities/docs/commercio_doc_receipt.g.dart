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

Map<String, dynamic> _$CommercioDocReceiptToJson(CommercioDocReceipt instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uuid', instance.uuid);
  writeNotNull('sender', instance.senderDid);
  writeNotNull('recipient', instance.recipientDid);
  writeNotNull('tx_hash', instance.txHash);
  writeNotNull('document_uuid', instance.documentUuid);
  writeNotNull('proof', instance.proof);
  return val;
}
