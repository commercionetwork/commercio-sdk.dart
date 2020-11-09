import 'package:commerciosdk/export.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

/// Allows to easily create a CommercioDocReceipt
/// and perform common related operations
class CommercioDocReceiptHelper {
  /// Creates a CommercioDoc from the given [wallet],
  /// [recipient], [txHash], [documentId]
  /// and optionally [proof].
  static CommercioDocReceipt fromWallet({
    @required Wallet wallet,
    @required String recipient,
    @required String txHash,
    @required String documentId,
    String proof = '',
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
