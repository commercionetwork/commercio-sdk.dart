import 'package:commerciosdk/crypto/sign_helper.dart';
import 'package:commerciosdk/export.dart';
import 'package:commerciosdk/id/id_utils.dart';
import 'package:hex/hex.dart';
import 'package:sacco/sacco.dart';

class IdHelper {
  /// Returns the Did Document associated with the given [did],
  /// or `null` if no Did Document was found.
  static Future<DidDocument> getDidDocument(String did, Wallet wallet) {
    final url = "${wallet.networkInfo.lcdUrl}/identities/${did}";
    return Network.query<DidDocument>(url);
  }

  /// Performs a transaction setting the specified [didDocument] as being
  /// associated with the address present inside the specified [wallet].
  static Future<TransactionResult> setDidDocument(
    DidDocument didDocument,
    Wallet wallet,
  ) {
    final msg = MsgSetDidDocument(didDocument: didDocument);
    return TxHelper.createSignAndSendTx([msg], wallet);
  }

  static Future<TransactionResult> requestDidDeposit(
    String recipient,
    List<StdCoin> amount,
    Wallet wallet,
  ) async {
    // Get the timestamp
    var timestamp = getTimeStamp();

    // Build the signature
    var signatureJson = DidDepositRequestSignatureJson(
      recipient: recipient,
      timeStamp: timestamp,
    );
    var signedJson = SignHelper.signSorted(signatureJson.toJson(), wallet);

    // Build the payload
    var payload = DidDepositRequestPayload(
        recipient: recipient,
        timeStamp: timestamp,
        signature: HEX.encode(signedJson));

    // Build the proof
    var result = await generateProof(payload);

    // Build the message and send the tx
    var msg = MsgRequestDidDeposit(
      recipientDid: recipient,
      amount: amount,
      depositProof: HEX.encode(result.encryptedProof),
      encryptionKey: HEX.encode(result.encryptedAesKey),
      senderDid: wallet.bech32Address,
    );
    return TxHelper.createSignAndSendTx([msg], wallet);
  }
}
