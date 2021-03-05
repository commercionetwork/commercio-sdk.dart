import 'dart:convert';

class TumblerResponse {
  final String height;
  final Result result;

  TumblerResponse({
    required this.height,
    required this.result,
  });

  factory TumblerResponse.fromRawJson(String str) =>
      TumblerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TumblerResponse.fromJson(Map<String, dynamic> json) =>
      TumblerResponse(
        height: json['height'],
        result: Result.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'height': height,
        'result': result.toJson(),
      };
}

class Result {
  final String tumblerAddress;

  Result({
    required this.tumblerAddress,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        tumblerAddress: json['tumbler_address'],
      );

  Map<String, dynamic> toJson() => {
        'tumbler_address': tumblerAddress,
      };
}
