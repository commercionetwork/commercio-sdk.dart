// To parse this JSON data, do
//
//     final identitiesResponse = identitiesResponseFromJson(jsonString);

import 'package:commerciosdk/entities/id/did_document.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class IdentityResponse {
  final String height;
  final Result result;

  IdentityResponse({
    @required this.height,
    @required this.result,
  });

  factory IdentityResponse.fromRawJson(String str) =>
      IdentityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IdentityResponse.fromJson(Map<String, dynamic> json) =>
      IdentityResponse(
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
