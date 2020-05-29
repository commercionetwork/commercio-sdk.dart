import 'package:commerciosdk/docs/commercio_doc_receipt_helper.dart';
import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class DocsHelper {
  final client = http.Client();

  /// Creates a new transaction that allows to share the document associated
  /// with the given [metadata] and having the optional [contentUri], [doSign],
  /// [checksum], [fee] and broadcasting [mode]. If [encryptedData] is specified,
  /// encrypts the proper data for the specified [recipients]
  /// and then sends the transaction to the blockchain.
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
    BroadcastingMode mode,
  }) async {
    // Build a generic document
    final CommercioDoc commercioDoc = await CommercioDocHelper.fromWallet(
      wallet: wallet,
      recipients: recipients,
      id: id,
      metadata: metadata,
      checksum: checksum,
      contentUri: contentUri,
      doSign: doSign,
      encryptedData: encryptedData,
      aesKey: aesKey,
    );

    // Build the tx message
    final msg = MsgShareDocument(document: commercioDoc);
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Creates a new transaction that allows to share from [wallet]
  /// a document lists [commercioDocsList].
  /// Optionally [fee] and broadcasting [mode] parameters can be specified.
  static Future<TransactionResult> shareDocumentsList(
    List<CommercioDoc> commercioDocsList,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msgs = commercioDocsList
        .map(
          (commercioDoc) => MsgShareDocument(document: commercioDoc),
        )
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
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
  /// having the specified [documentId] and present inside the transaction
  /// with [txHash] has been properly seen; optionally [proof] of reading,
  /// [fee] and broadcasting [mode].
  static Future<TransactionResult> sendDocumentReceipt({
    @required String recipient,
    @required String txHash,
    @required String documentId,
    @required Wallet wallet,
    String proof = "",
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final CommercioDocReceipt commercioDocReceipt =
        CommercioDocReceiptHelper.fromWallet(
      wallet: wallet,
      recipient: recipient,
      txHash: txHash,
      documentId: documentId,
      proof: proof,
    );
    final msg = MsgSendDocumentReceipt(
      receipt: commercioDocReceipt,
    );
    return TxHelper.createSignAndSendTx(
      [msg],
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Creates a new transaction which sends from [wallet]
  /// a document receipts list[commercioDocReceiptsList]
  static Future<TransactionResult> sendDocumentReceiptsList(
    List<CommercioDocReceipt> commercioDocReceiptsList,
    Wallet wallet, {
    StdFee fee,
    BroadcastingMode mode,
  }) {
    final msgs = commercioDocReceiptsList
        .map(
          (commercioDocReceipt) =>
              MsgSendDocumentReceipt(receipt: commercioDocReceipt),
        )
        .toList();
    return TxHelper.createSignAndSendTx(
      msgs,
      wallet,
      fee: fee,
      mode: mode,
    );
  }

  /// Returns the list of all the [CommercioDocReceipt] that
  /// have been sent from the given [address].
  static Future<List<CommercioDocReceipt>> getSentReceipts(
    String address,
    Wallet wallet,
  ) async {
    final url = "${wallet.networkInfo.lcdUrl}/receipts/${address}/sent";
    final response = await Network.queryChain(url) as List;
    return response.map((json) => CommercioDocReceipt.fromJson(json)).toList();
  }

  /// Returns the list of all the [CommercioDocReceipt] that
  /// have been received from the given [address].
  static Future<List<CommercioDocReceipt>> getReceivedReceipts(
    String address,
    Wallet wallet,
  ) async {
    final url = "${wallet.networkInfo.lcdUrl}/receipts/${address}/received";
    final response = await Network.queryChain(url) as List;
    return response.map((json) => CommercioDocReceipt.fromJson(json)).toList();
  }
}
