// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResponse _$TestResponseFromJson(Map<String, dynamic> json) {
  return TestResponse(
    (json['result'] as List<dynamic>?)
        ?.map((e) => TestData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TestResponseToJson(TestResponse instance) =>
    <String, dynamic>{
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };

TestData _$TestDataFromJson(Map<String, dynamic> json) {
  return TestData(
    json['sender'] as String,
    json['uuid'] as String,
  );
}

Map<String, dynamic> _$TestDataToJson(TestData instance) => <String, dynamic>{
      'sender': instance.sender,
      'uuid': instance.uuid,
    };
