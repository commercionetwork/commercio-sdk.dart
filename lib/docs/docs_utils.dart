import 'package:commerciosdk/entities/export.dart';
import 'package:commerciosdk/export.dart';
import 'package:hex/hex.dart';
import 'package:sacco/sacco.dart';

enum EncryptedData {
  CONTENT,
  CONTENT_URI,
  METADATA_CONTENT_URI,
  METADATA_SCHEMA_URI
}

/// Represents a pair that associates a Did document to its encryption key.
class _Pair {
  final DidDocument first;
  final RSAPublicKey second;

  _Pair({this.first, this.second});
}

/// Converts a [didDocument] to a [_Pair].
_Pair _didDocumentToPair(DidDocument didDocument) {
  final key = didDocument.encryptionKey;
  if (key == null) {
    return null;
  }

  return _Pair(first: didDocument, second: key);
}

/// Transforms [this] document into one having the proper fields encrypted as
/// specified inside the [encryptedData] list.
/// All the fields will be encrypted using the specified [aesKey].
/// This key will later be encrypted for each and every Did specified into
/// the [recipients] list.
/// The overall encrypted data will be put inside the proper document field.
Future<CommercioDoc> encryptField(
  CommercioDoc doc,
  Key aesKey,
  List<EncryptedData> encryptedData,
  List<String> recipients,
  Wallet wallet,
) async {
  // -----------------
  // --- Encryption
  // -----------------

  // Encrypt the contents
  var encryptedContentUri = null;
  if (encryptedData.contains(EncryptedData.CONTENT_URI)) {
    encryptedContentUri = HEX.encode(
      EncryptionHelper.encryptStringWithAes(doc.contentUri, aesKey),
    );
  }

  var encryptedMetadataContentUri = null;
  if (encryptedData.contains(EncryptedData.METADATA_CONTENT_URI)) {
    encryptedMetadataContentUri = HEX.encode(
      EncryptionHelper.encryptStringWithAes(doc.metadata.contentUri, aesKey),
    );
  }

  var encryptedMetadataSchemaUri = null;
  if (encryptedData.contains(EncryptedData.METADATA_SCHEMA_URI)) {
    var schemaUri = doc.metadata.schema?.uri;
    if (schemaUri != null) {
      encryptedMetadataSchemaUri = HEX.encode(
        EncryptionHelper.encryptStringWithAes(schemaUri, aesKey),
      );
    }
  }

  // ---------------------
  // --- Keys creation
  // ---------------------

  // Get the recipients Did Documents
  final recipientsDidDocs = Future.wait(recipients.map((r) async {
    return IdHelper.getDidDocument(r, wallet);
  }));

  // Get a list of al the Did Documents and the associated encryption key
  final keys = (await recipientsDidDocs)
      .where((didDocument) => didDocument != null)
      .map((didDocument) => _didDocumentToPair(didDocument))
      .where((pair) => pair != null);

  // Create the encryption key field
  final encryptionKeys = keys.map((pair) {
    final encryptedAesKey = EncryptionHelper.encryptBytesWithRsa(
      aesKey.bytes,
      pair.second,
    );
    CommercioDocEncryptionDataKey(
      recipientDid: pair.first.id,
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
      encryptedData: encryptedData.map((e) => e.toString()).toList(),
    ),
  );
}
