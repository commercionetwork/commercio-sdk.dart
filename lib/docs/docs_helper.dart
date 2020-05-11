import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class DocsHelper {
  final client = http.Client();

  /// Creates a new transaction that allows to share the document associated
  /// with the given [metadata] and having the optional [contentUri], [doSign]
  /// and [checksum]. If [encryptedData] is specified, encrypts the proper
  /// data for the specified [recipients] and then sends the transaction
  /// to the blockchain.
  static Future<TransactionResult> shareDocument({
    @required String id,
    @required CommercioDocMetadata metadata,
    @required List<String> recipients,
    @required Wallet wallet,
    CommercioDoSign doSign,
    CommercioDocChecksum checksum,
    Key aesKey,
    List<EncryptedData> encryptedData,
    StdFee fee,
    String contentUri,
  }) async {
    // Build a generic document
    CommercioDoc commercioDocument = CommercioDoc(
      senderDid: wallet.bech32Address,
      recipientDids: recipients,
      uuid: id,
      contentUri: contentUri,
      metadata: metadata,
      checksum: checksum,
      encryptionData: null,
      doSign: doSign,
    );

    // Encrypt its contents, if necessary
    if (encryptedData != null && encryptedData.isNotEmpty) {
      // Get a default aes key for encryption if needed
      final key = aesKey != null ? aesKey : await KeysHelper.generateAesKey();

      commercioDocument = await encryptField(
        commercioDocument,
        key,
        encryptedData,
        recipients,
        wallet,
      );
    }

    // Build the tx message
    final msg = MsgShareDocument(document: commercioDocument);
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
    );
  }

  /// Returns the list of all the [CommercioDoc] that the
  /// specified [address] has sent.
  static Future<List<CommercioDoc>> getSendDocuments(
    String address,
    Wallet wallet,
  ) async {
    final url = "${wallet.networkInfo.lcdUrl}/docs/${address}/sent";
    final response = await Network.queryChain(url) as List;
    return response.map((json) => CommercioDoc.fromJson(json)).toList();
  }

  /// Returns the list of all the [CommercioDoc] that the
  /// specified [address] has received.
  static Future<List<CommercioDoc>> getReceivedDocuments(
    String address,
    Wallet wallet,
  ) async {
    final url = "${wallet.networkInfo.lcdUrl}/docs/${address}/received";
    final response = await Network.queryChain(url) as List;
    return response.map((json) => CommercioDoc.fromJson(json)).toList();
  }

  /// Creates a new transaction which tells the [recipient] that the document
  /// having the specified [documentId] and present inside the transaction with
  /// hash [txHash] has been properly seen.
  /// [proof] optional proof of reading.
  static Future<TransactionResult> sendDocumentReceipt({
    @required String recipient,
    @required String txHash,
    @required String documentId,
    @required Wallet wallet,
    String proof = "",
    StdFee fee,
  }) {
    final msg = MsgSendDocumentReceipt(
      CommercioDocReceipt(
        uuid: Uuid().v4(),
        recipientDid: recipient,
        txHash: txHash,
        documentUuid: documentId,
        proof: proof,
        senderDid: wallet.bech32Address,
      ),
    );
    return TxHelper.createSignAndSendTx([msg], wallet, fee: fee);
  }

  /// Returns the list of all the [CommercioDocReceipt] that
  /// have been sent from the given [address].
  Future<List<CommercioDocReceipt>> getSentReceipts(
    String address,
    Wallet wallet,
  ) async {
    final url = "${wallet.networkInfo.lcdUrl}/receipts/${address}/sent";
    final response = await Network.queryChain(url) as List;
    return response.map((json) => CommercioDocReceipt.fromJson(json)).toList();
  }

  /// Returns the list of all the [CommercioDocReceipt] that
  /// have been received from the given [address].
  Future<List<CommercioDocReceipt>> getReceivedReceipts(
    String address,
    Wallet wallet,
  ) async {
    final url = "${wallet.networkInfo.lcdUrl}/receipts/${address}/received";
    final response = await Network.queryChain(url) as List;
    return response.map((json) => CommercioDocReceipt.fromJson(json)).toList();
  }
}
