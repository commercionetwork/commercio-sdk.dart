// To parse this JSON data, do
//
//     final identitiesResponse = identitiesResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class IdentitiesResponse {
    final String height;
    final Result result;

    IdentitiesResponse({
        @required this.height,
        @required this.result,
    });

    factory IdentitiesResponse.fromRawJson(String str) => IdentitiesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory IdentitiesResponse.fromJson(Map<String, dynamic> json) => IdentitiesResponse(
        height: json["height"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "result": result.toJson(),
    };
}

class Result {
    final String owner;
    final DidDocument didDocument;

    Result({
        @required this.owner,
        @required this.didDocument,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        owner: json["owner"],
        didDocument: DidDocument.fromJson(json["did_document"]),
    );

    Map<String, dynamic> toJson() => {
        "owner": owner,
        "did_document": didDocument.toJson(),
    };
}

class DidDocument {
    final String context;
    final String id;
    final List<PublicKey> publicKey;
    final Proof proof;

    DidDocument({
        @required this.context,
        @required this.id,
        @required this.publicKey,
        @required this.proof,
    });

    factory DidDocument.fromRawJson(String str) => DidDocument.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DidDocument.fromJson(Map<String, dynamic> json) => DidDocument(
        context: json["@context"],
        id: json["id"],
        publicKey: List<PublicKey>.from(json["publicKey"].map((x) => PublicKey.fromJson(x))),
        proof: Proof.fromJson(json["proof"]),
    );

    Map<String, dynamic> toJson() => {
        "@context": context,
        "id": id,
        "publicKey": List<dynamic>.from(publicKey.map((x) => x.toJson())),
        "proof": proof.toJson(),
    };
}

class Proof {
    final String type;
    final DateTime created;
    final String proofPurpose;
    final String controller;
    final String verificationMethod;
    final String signatureValue;

    Proof({
        @required this.type,
        @required this.created,
        @required this.proofPurpose,
        @required this.controller,
        @required this.verificationMethod,
        @required this.signatureValue,
    });

    factory Proof.fromRawJson(String str) => Proof.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Proof.fromJson(Map<String, dynamic> json) => Proof(
        type: json["type"],
        created: DateTime.parse(json["created"]),
        proofPurpose: json["proofPurpose"],
        controller: json["controller"],
        verificationMethod: json["verificationMethod"],
        signatureValue: json["signatureValue"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "created": created.toIso8601String(),
        "proofPurpose": proofPurpose,
        "controller": controller,
        "verificationMethod": verificationMethod,
        "signatureValue": signatureValue,
    };
}

class PublicKey {
    final String id;
    final String type;
    final String controller;
    final String publicKeyPem;

    PublicKey({
        @required this.id,
        @required this.type,
        @required this.controller,
        @required this.publicKeyPem,
    });

    factory PublicKey.fromRawJson(String str) => PublicKey.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PublicKey.fromJson(Map<String, dynamic> json) => PublicKey(
        id: json["id"],
        type: json["type"],
        controller: json["controller"],
        publicKeyPem: json["publicKeyPem"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "controller": controller,
        "publicKeyPem": publicKeyPem,
    };
}
