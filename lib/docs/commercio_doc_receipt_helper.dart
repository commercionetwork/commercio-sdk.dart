import 'package:commerciosdk/export.dart';
import 'package:uuid/uuid.dart';

/// Allows to easily create a [CommercioDocReceipt] and perform common related
/// operations.
class CommercioDocReceiptHelper {
  /// Build a `CommercioDocReceipt` from the given [wallet], [recipient],
  /// [txHash], [documentId] and an optional [proof].
  ///
  /// The [txHash] is the transaction in the blockchain that contains the
  /// [CommercioDoc] that you want to generate a recepit for. You can get the
  /// [recipient], that is, the [CommercioDoc] sender and the [documentId] from
  /// the transaction data.
  ///
  /// The [proof] should be some kind of agreeded method between the
  /// [CommercioDoc] sender and receivers that the documen has been read.
  static CommercioDocReceipt fromWallet({
    required Wallet wallet,
    required String recipient,
    required String txHash,
    required String documentId,
    String? proof,
  }) {
    return CommercioDocReceipt(
      uuid: Uuid().v4(),
      senderDid: wallet.bech32Address,
      recipientDid: recipient,
      txHash: txHash,
      documentUuid: documentId,
      proof: proof,
    );
  }
}
