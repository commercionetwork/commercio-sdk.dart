import 'dart:convert';

import 'package:commerciosdk/export.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

part 'network_test.g.dart';

void main() {
  final testData = [
    TestData(
      'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
      '6a881ef0-04da-4524-b7ca-6e5e3b7e61dc',
    ),
  ];
  final testResponse = TestResponse(testData);

  test('query returns correct data', () async {
    // Build the mock client
    final clientMock = MockClient((_) async {
      final responseBody = jsonEncode(testResponse);
      return Response(responseBody, 200);
    });

    final result = await Network.queryChain(
      Uri.parse('http://example.com'),
      client: clientMock,
    ) as List<dynamic>;
    final testDataList = result.map((json) => TestData.fromJson(json)).toList();
    expect(testDataList.length, 1);
    expect(
      'did:com:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
      testDataList[0].sender,
    );
    expect('6a881ef0-04da-4524-b7ca-6e5e3b7e61dc', testDataList[0].uuid);
  });

  test('query with response status != 200 should return null', () async {
    // Build the mock client
    final clientMock = MockClient((_) async => Response('', 400));

    final result = await Network.query(
      Uri.parse('http://example.com'),
      client: clientMock,
    );

    expect(result, isNull);
  });

  test(
      'queryChain should return null if the returned JSON does not have the key "result"',
      () async {
    // Build the mock client
    final clientMock = MockClient((_) async => Response(jsonEncode({}), 200));

    final result = await Network.queryChain(
      Uri.parse('http://example.com'),
      client: clientMock,
    );

    expect(result, isNull);
  });

  test('queryChain without json in body should return null', () async {
    // Build the mock client
    final clientMock = MockClient((request) async {
      return Response('', 200);
    });

    final result = await Network.queryChain(
      Uri.parse('http://example.com'),
      client: clientMock,
    );

    expect(result, isNull);
  });

  test('Default client should return null in test', () async {
    final response = await Network.query(Uri.parse(''));

    expect(response, isNull);
  });
}

@JsonSerializable(explicitToJson: true)
class TestResponse {
  final List<TestData> result;

  TestResponse(this.result);

  factory TestResponse.fromJson(Map<String, dynamic> json) =>
      _$TestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TestResponseToJson(this);
}

@JsonSerializable()
class TestData {
  @JsonKey(name: 'sender')
  final String sender;
  @JsonKey(name: 'uuid')
  final String uuid;

  TestData(this.sender, this.uuid);

  factory TestData.fromJson(Map<String, dynamic> json) =>
      _$TestDataFromJson(json);

  Map<String, dynamic> toJson() => _$TestDataToJson(this);
}
