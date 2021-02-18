import 'package:commerciosdk/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'did_document_service.g.dart';

/// Contains the data of a service that can accept the Did Document as
/// authentication method or something else.
@JsonSerializable(explicitToJson: true)
class DidDocumentService extends Equatable {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'serviceEndpoint')
  final String endpoint;

  DidDocumentService({
    @required this.id,
    @required this.type,
    @required this.endpoint,
  })  : assert(id != null && checkStringBytesLen(id, 64)),
        assert(type != null && checkStringBytesLen(type, 64)),
        assert(endpoint != null && checkStringBytesLen(endpoint, 512));

  @override
  List<Object> get props {
    return [id, type, endpoint];
  }

  factory DidDocumentService.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentServiceFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentServiceToJson(this);
}
