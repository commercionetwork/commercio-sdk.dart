import 'package:commerciosdk/entities/docs/commercio_doc.dart';

import 'commercio_doc.dart' as legacy;

class CommercioDocMapper {
  /// Converts the provided [commercioDoc] and returns a [legacy.CommercioDoc]
  /// version compatible with a 2.1 chain.
  static legacy.CommercioDoc toLegacy(CommercioDoc commercioDoc) {
    legacy.CommercioDocMetadataSchema? metadataSchema;

    if (commercioDoc.metadata.schema != null) {
      metadataSchema = legacy.CommercioDocMetadataSchema(
        uri: commercioDoc.metadata.schema!.uri,
        version: commercioDoc.metadata.schema!.version,
      );
    }

    final metadata = legacy.CommercioDocMetadata(
      contentUri: commercioDoc.metadata.contentUri,
      schema: metadataSchema,
      schemaType: commercioDoc.metadata.schemaType ?? '',
    );

    legacy.CommercioDocChecksum? checksum;

    if (commercioDoc.checksum != null) {
      checksum = legacy.CommercioDocChecksum(
        algorithm: _checksumAlgorithmToLegacy(commercioDoc.checksum!.algorithm),
        value: commercioDoc.checksum!.value,
      );
    }

    legacy.CommercioDoSign? doSign;

    if (commercioDoc.doSign != null) {
      doSign = legacy.CommercioDoSign(
        certificateProfile: commercioDoc.doSign!.certificateProfile,
        signerIstance: commercioDoc.doSign!.signerIstance,
        storageUri: commercioDoc.doSign!.storageUri,
        vcrId: commercioDoc.doSign!.vcrId,
        sdnData: commercioDoc.doSign!.sdnData
            ?.map((e) => _sdnDataToLegacy(e))
            .toList(),
      );
    }

    legacy.CommercioDocEncryptionData? encryptionData;

    if (commercioDoc.encryptionData != null) {
      encryptionData = legacy.CommercioDocEncryptionData(
        encryptedData: commercioDoc.encryptionData!.encryptedData
            .map((e) => e.value)
            .toList(),
        keys: commercioDoc.encryptionData!.keys
            .map((e) => _encryptionDataKeyToLegacy(e))
            .toList(),
      );
    }

    return legacy.CommercioDoc(
      senderDid: commercioDoc.senderDid,
      recipientDids: commercioDoc.recipientDids,
      uuid: commercioDoc.uuid,
      metadata: metadata,
      contentUri: commercioDoc.contentUri,
      checksum: checksum,
      doSign: doSign,
      encryptionData: encryptionData,
    );
  }

  static legacy.CommercioDocChecksumAlgorithm _checksumAlgorithmToLegacy(
    CommercioDocChecksumAlgorithm algorithm,
  ) {
    switch (algorithm) {
      case CommercioDocChecksumAlgorithm.MD5:
        return legacy.CommercioDocChecksumAlgorithm.MD5;
      case CommercioDocChecksumAlgorithm.SHA1:
        return legacy.CommercioDocChecksumAlgorithm.SHA1;
      case CommercioDocChecksumAlgorithm.SHA224:
        return legacy.CommercioDocChecksumAlgorithm.SHA224;
      case CommercioDocChecksumAlgorithm.SHA256:
        return legacy.CommercioDocChecksumAlgorithm.SHA256;
      case CommercioDocChecksumAlgorithm.SHA384:
        return legacy.CommercioDocChecksumAlgorithm.SHA384;
      case CommercioDocChecksumAlgorithm.SHA512:
        return legacy.CommercioDocChecksumAlgorithm.SHA512;
      default:
        throw ArgumentError('Unsupported algorithm $algorithm');
    }
  }

  static legacy.CommercioSdnData _sdnDataToLegacy(CommercioSdnData sdnData) {
    switch (sdnData) {
      case CommercioSdnData.COMMON_NAME:
        return legacy.CommercioSdnData.COMMON_NAME;
      case CommercioSdnData.COUNTRY:
        return legacy.CommercioSdnData.COUNTRY;
      case CommercioSdnData.GIVEN_NAME:
        return legacy.CommercioSdnData.GIVEN_NAME;
      case CommercioSdnData.ORGANIZATION:
        return legacy.CommercioSdnData.ORGANIZATION;
      case CommercioSdnData.SERIAL_NUMBER:
        return legacy.CommercioSdnData.SERIAL_NUMBER;
      case CommercioSdnData.SURNAME:
        return legacy.CommercioSdnData.SURNAME;
      default:
        throw ArgumentError('Unsupported SdnData $sdnData');
    }
  }

  static legacy.CommercioDocEncryptionDataKey _encryptionDataKeyToLegacy(
    CommercioDocEncryptionDataKey dataKey,
  ) {
    return legacy.CommercioDocEncryptionDataKey(
      recipientDid: dataKey.recipientDid,
      value: dataKey.value,
    );
  }
}
