import 'package:commerciosdk/export.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;

/// Transforms [doc] into one having the proper fields encrypted as
/// specified inside the [encryptedData] list.
/// All the fields will be encrypted using the specified [aesKey].
/// This key will later be encrypted for each and every Did specified into
/// the [recipients] list.
/// The overall encrypted data will be put inside the proper document field.
///
/// Throws [ArgumentError] if:
/// * Is provided [CommercioEncryptedData.CONTENT_URI] without a valid
///   [contentUri].
/// *Is provided [CommercioEncryptedData.METADATA_SCHEMA_URI] without a
/// [schema].
Future<CommercioDoc> encryptField(
  CommercioDoc doc,
  Key aesKey,
  Set<CommercioEncryptedData> encryptedData,
  List<String> recipients,
  Wallet wallet, {
  http.Client client,
}) async {
  // -----------------
  // --- Encryption
  // -----------------

  // Encrypt the contents
  String encryptedContentUri;
  if (encryptedData.contains(CommercioEncryptedData.CONTENT_URI)) {
    if (doc.contentUri == null) {
      throw ArgumentError(
        'Document contentUri field can not be null if the encryptedData arguments contains CommercioEncryptedData.CONTENT_URI',
      );
    }

    encryptedContentUri = HEX.encode(
      EncryptionHelper.encryptStringWithAes(
        doc.contentUri,
        aesKey,
      ),
    );
  }

  String encryptedMetadataContentUri;
  if (encryptedData.contains(CommercioEncryptedData.METADATA_CONTENT_URI)) {
    encryptedMetadataContentUri = HEX.encode(
      EncryptionHelper.encryptStringWithAes(
        doc.metadata.contentUri,
        aesKey,
      ),
    );
  }

  String encryptedMetadataSchemaUri;
  if (encryptedData.contains(CommercioEncryptedData.METADATA_SCHEMA_URI)) {
    if (doc.metadata.schema == null) {
      throw ArgumentError(
        'Document metadata.schema field can not be null if the encryptedData arguments contains CommercioEncryptedData.METADATA_SCHEMA_URI',
      );
    }
    encryptedMetadataSchemaUri = HEX.encode(
      EncryptionHelper.encryptStringWithAes(
        doc.metadata.schema.uri,
        aesKey,
      ),
    );
  }

  // ---------------------
  // --- Keys creation
  // ---------------------

  // Get the recipients Did Documents
  final recipientsWithDDO = await Future.wait(recipients.map((r) async {
    final didDoc = await IdHelper.getDidDocument(r, wallet, client: client);

    return MapEntry(r, didDoc);
  }));

  // Throw if any of the recipients does not have an identity associated to them
  for (final recipient in recipientsWithDDO) {
    if (recipient.value == null) {
      throw WalletIdentityNotFoundException.fromAddress(recipient.key);
    }
  }

  // Create the encryption key field
  final encryptionKeys = recipientsWithDDO.map((recipient) {
    final encryptedAesKey = EncryptionHelper.encryptBytesWithRsa(
      aesKey.bytes,
      recipient.value.encryptionKey,
    );
    return CommercioDocEncryptionDataKey(
      recipientDid: recipient.key,
      value: HEX.encode(encryptedAesKey),
    );
  }).toList();

  // Copy the metadata
  var metadataSchema = doc.metadata?.schema;
  if (metadataSchema != null) {
    metadataSchema = CommercioDocMetadataSchema(
      version: metadataSchema.version,
      uri: encryptedMetadataSchemaUri ?? metadataSchema.uri,
    );
  }

  // Return a copy of the document
  return CommercioDoc(
    senderDid: doc.senderDid,
    recipientDids: doc.recipientDids,
    uuid: doc.uuid,
    checksum: doc.checksum,
    contentUri: encryptedContentUri ?? doc.contentUri,
    metadata: CommercioDocMetadata(
      contentUri: encryptedMetadataContentUri ?? doc.metadata.contentUri,
      schema: metadataSchema,
      schemaType: doc.metadata.schemaType,
    ),
    encryptionData: CommercioDocEncryptionData(
      keys: encryptionKeys,
      encryptedData: encryptedData,
    ),
    doSign: doc.doSign,
  );
}

class WalletIdentityNotFoundException implements Exception {
  /// Exception used to notify the caller that he tried to share an
  /// **encrypted** [CommercioDoc] but one or more recipients does not have
  /// an associated identity.
  ///
  /// In general this exception should be instantiated with the factory
  /// constructor `fromAddress()`.
  ///
  /// Please refer to
  /// https://docs.commercio.network/x/id/tx/create-an-identity.html
  /// on how create an identity and associate it to a wallet.
  const WalletIdentityNotFoundException(this.message) : assert(message != null);

  /// Create a default-message exception that refers to the missing identity of
  /// the provided `walletAddress`.
  factory WalletIdentityNotFoundException.fromAddress(String walletAddress) =>
      WalletIdentityNotFoundException(
          'Could not find the identity of the wallet $walletAddress. Please make sure that all your recipients have an identity to send encrypted documents to them.');

  /// The exception message.
  final String message;
}
