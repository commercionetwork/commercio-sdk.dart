import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class DocsHelper {
  final client = http.Client();

  /// Creates a new transaction that allows to share the document associated
  /// with the given [contentUri] and having the given [metadata]
  /// and [checksum]. If [encryptedData] is specified, encrypts the proper
  /// data for the specified [recipients] and then sends the transaction
  /// to the blockchain.
  static Future<TransactionResult> shareDocument({
    @required String id,
    @required String contentUri,
    @required CommercioDocMetadata metadata,
    @required List<String> recipients,
    @required List<StdCoin> fees,
    @required Wallet wallet,
    CommercioDocChecksum checksum,
    Key aesKey,
    List<EncryptedData> encryptedData = const [],
    CommercioDoSign doSign = null,
  }) async {
    // Get a default aes key for encryption if needed
    if (aesKey == null) {
      aesKey = await KeysHelper.generateAesKey();
    }

    // Build a generic document
    final document = CommercioDoc(
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
    var finalDoc = document;
    if (encryptedData.isNotEmpty) {
      finalDoc = await encryptField(
        document,
        aesKey,
        encryptedData,
        recipients,
        wallet,
      );
    }

    // Build the tx message
    final msg = MsgShareDocument(document: finalDoc);
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: StdFee(gas: "200000", amount: fees),
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
