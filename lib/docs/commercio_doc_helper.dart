import 'package:commerciosdk/export.dart';
import 'package:http/http.dart' as http;

/// Allows to easily create a CommercioDoc and perform common related operations
class CommercioDocHelper {
  /// Creates a CommercioDoc from the given [wallet],
  /// [recipients], [id], [metadata]
  /// and optionally [contentUri], [checksum],
  /// [doSign], [encryptedData], [aesKey].
  static Future<CommercioDoc> fromWallet({
    required Wallet wallet,
    required List<String> recipients,
    required String id,
    required CommercioDocMetadata metadata,
    String? contentUri,
    CommercioDocChecksum? checksum,
    CommercioDoSign? doSign,
    Set<CommercioEncryptedData>? encryptedData,
    Uint8List? aesKey,
    http.Client? client,
  }) async {
    // Build a commercio document
    var commercioDocument = CommercioDoc(
      senderDid: wallet.bech32Address,
      recipientDids: recipients,
      uuid: id,
      contentUri: contentUri,
      metadata: metadata,
      checksum: checksum,
      doSign: doSign,
    );

    // Encrypt its contents, if necessary
    if (encryptedData != null && encryptedData.isNotEmpty) {
      // Get a default aes key for encryption if needed
      final key = aesKey ?? await KeysHelper.generateAesKey();

      commercioDocument = await encryptField(
        commercioDocument,
        key,
        encryptedData,
        recipients,
        wallet,
        client: client,
      );
    }

    return commercioDocument;
  }
}
