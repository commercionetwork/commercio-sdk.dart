import 'dart:convert';
import 'dart:io';

import 'package:commerciosdk/export.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "RequestDidPowerUpHelper" class', () {
    const lcdUrl = 'url';
    final networkInfo = NetworkInfo(bech32Hrp: 'did:com:', lcdUrl: lcdUrl);
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);
    final pairwaisedWallet = Wallet.derive(
      mnemonic,
      networkInfo,
      lastDerivationPathSegment: '1',
    );
    const amount = [
      StdCoin(
        denom: 'denom',
        amount: '10',
      ),
    ];

    test('"fromWallet()" returns a well-formed "RequestDidPowerUp" object.',
        () async {
      final clientMock = MockClient((request) async {
        if (request.url.path == '$lcdUrl/government/tumbler') {
          final body =
              await File('test_resources/tumbler_address.json').readAsString();
          return Future.value(Response(body, 200));
        }

        final body =
            await File('test_resources/tumbler_identity.json').readAsString();
        return Future.value(Response(body, 200));
      });

      final keyPair = await KeysHelper.generateRsaKeyPair();

      const powerUpProof = 'powerUpProof';
      final uuid = Uuid().v4();
      const encryptionKey = 'encryptionKey';

      final expectedRequestDidPowerUp = RequestDidPowerUp(
        claimantDid: wallet.bech32Address,
        amount: amount,
        powerUpProof: base64Encode(
          utf8.encode(powerUpProof),
        ),
        uuid: uuid,
        encryptionKey: base64Encode(
          utf8.encode(encryptionKey),
        ),
      );

      final requestDidPowerUp = await RequestDidPowerUpHelper.fromWallet(
        wallet: wallet,
        pairwiseDid: pairwaisedWallet.bech32Address,
        amount: amount,
        privateKey: keyPair.privateKey,
      );

      expect(
          requestDidPowerUp.claimantDid, expectedRequestDidPowerUp.claimantDid);
      expect(requestDidPowerUp.amount.length,
          expectedRequestDidPowerUp.amount.length);
      expect(requestDidPowerUp.amount[0].toJson(),
          expectedRequestDidPowerUp.amount[0].toJson());
      expect(requestDidPowerUp.uuid, isNot(expectedRequestDidPowerUp.uuid));
      expect(requestDidPowerUp.powerUpProof,
          isNot(expectedRequestDidPowerUp.powerUpProof));
      expect(requestDidPowerUp.encryptionKey,
          isNot(expectedRequestDidPowerUp.encryptionKey));
    });
  });
}
