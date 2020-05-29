import 'dart:convert';

import 'package:commerciosdk/export.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "RequestDidPowerUpHelper" class', () {
    final networkInfo = NetworkInfo(bech32Hrp: "did:com:", lcdUrl: "");
    final mnemonicString =
        "dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology";
    final mnemonic = mnemonicString.split(" ");
    final wallet = Wallet.derive(mnemonic, networkInfo);
    final pairwaisedWallet = Wallet.derive(
      mnemonic,
      networkInfo,
      lastDerivationPathSegment: '1',
    );

    test('"fromWallet()" returns a well-formed "RequestDidPowerUp" object.',
        () async {
      // const addressJson =
      //     '{"height":"0","result":{"tumbler_address": "did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau"}}';
      // final identityResponse =
      //     '{"height":"0","result":{"owner":"did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau","did_document":{"@context":"https://www.w3.org/ns/did/v1","id":"did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau","publicKey":[{"id":"did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau#keys-1","type":"RsaVerificationKey2018","controller":"did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau","publicKeyPem":"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0LwlHDabWnycQUGoscz/\n0SRVy0r5Vf71hUpws1jxwXjRHyE3OxEhIhnfhKzkhQXBHpt7ibwju8a4ubLOBDm6\nL9rQI7isNeKfDoTvKzHZAlVWA3FfzMCkqSHY+VJE1JcxkJ2IN+7Q/mk3Av73qK43\nW2h9ygrDhDJv65cTJ8S7qHYHWNd0Y1A88AG6F90SH677PkDbCrQEjrG6YUuZQsGD\nYc0WgPqiOxQ/YvMMpl3uWyLY1Hc9D0lhHEPS/Fyre9kMqpcNt9CM0cAmJSvLi6g1\nEEqJx6PWVrrw2WKJBMvuo4OMt6JTkdPISmq8MI5BNWOZzQpkeJeNPN8v6KNbZ7gz\nkwIDAQAB\n-----END PUBLIC KEY-----\n"},{"id":"did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau#keys-2","type":"RsaSignatureKey2018","controller":"did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau","publicKeyPem":"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqlaQEW4FrAH6P9pzEmo9\nr0ytKQMmFrQ/HAYK+YTUc3olNVo0s7nGTkGsp4gnTkutvITFlSBPi387CKBTotvg\nLNSBFXRiiKfF1ZYfekP4kZ7hAIqlysWdwjmrdHO9gpSUdYCaYQr/wymeEv92ReRd\nCZYtzrfzkKZrZT5TrUoQG0X07b44YQG0PE+3cfoTOo0IWiJ2dUBkOyLwD1XNoQ4q\n4cu4rzh3AK9IQr8Xte732A6x9uayvPaLtxFzxzxxMPpT5HnbaWzDGEukxm4UQol3\nw7rogs5Y7e/Xxs8uGJQxoOqSaLLyB7BX7AnUY05A3yZYG/bfrWn77q7vSvi+Nf9t\nbQIDAQAB\n-----END PUBLIC KEY-----\n"}],"proof":{"type":"EcdsaSecp256k1VerificationKey2019","created":"2020-05-12T09:17:44.163534708Z","proofPurpose":"authentication","controller":"did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau","verificationMethod":"did:com:pub1addwnpepqdnzje8vxh4xrdg8aa6lsjegukqhtmrjeux26z7zlk5zry8fp04rcw3vxec","signatureValue":"MnhISqHW6N0ziIwKJ+gPgfSUPdE4E+/fPSRgff/xZTwe3d9Jqpynhdb09ma3qEKZrVwNaThdvOIOe6a/m4RIRg=="}}}}';
      // Network.client = MockClient((request) {
      //   if (request.url.path == '/government/tumbler')
      //     return Future.value(Response(addressJson, 200));
      //   return Future.value(Response(identityResponse, 200));
      // });

      // final keyPair = await KeysHelper.generateRsaKeyPair();
      // final claimantDid = wallet.bech32Address;
      // final amount = [StdCoin(denom: 'denom', amount: '10')];
      // final powerUpProof = 'powerUpProof';
      // final uuid = Uuid().v4();
      // final encryptionKey = 'encryptionKey';
      // final expectedRequestDidPowerUp = RequestDidPowerUp(
      //   claimantDid: claimantDid,
      //   amount: amount,
      //   powerUpProof: base64Encode(
      //     utf8.encode(powerUpProof),
      //   ),
      //   uuid: uuid,
      //   encryptionKey: base64Encode(
      //     utf8.encode(encryptionKey),
      //   ),
      // );

      // final requestDidPowerUp = await RequestDidPowerUpHelper.fromWallet(
      //   wallet,
      //   pairwaisedWallet.bech32Address,
      //   amount,
      //   keyPair.privateKey,
      // );
    });
  });
}
