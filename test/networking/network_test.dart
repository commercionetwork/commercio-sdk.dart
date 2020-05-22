import 'dart:io';

import 'package:commerciosdk/export.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

part 'network_test.g.dart';

void main() {
  test('query returns correct data', () async {
    // Build the mock client
    final client = MockClient((request) async {
      final responseFile = File('test_resources/sent_documents_response.json');
      final responseBody = await responseFile.readAsString();
      return Response(responseBody, 200);
    });

    // Setup the client
    Network.client = client;

    final result =
        await Network.queryChain("http://example.com") as List<dynamic>;
    final testDataList = result.map((json) => TestData.fromJson(json)).toList();
    expect(testDataList.length, 4);
    expect("did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v",
        testDataList[0].sender);
    expect("6a881ef0-04da-4524-b7ca-6e5e3b7e61dc", testDataList[1].uuid);
  });
}

@JsonSerializable()
class TestData {
  @JsonKey(name: "sender")
  final String sender;
  @JsonKey(name: "uuid")
  final String uuid;

  TestData(this.sender, this.uuid);

  factory TestData.fromJson(Map<String, dynamic> json) =>
      _$TestDataFromJson(json);

  Map<String, dynamic> toJson() => _$TestDataToJson(this);
}
