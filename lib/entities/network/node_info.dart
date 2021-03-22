import 'package:json_annotation/json_annotation.dart';

part 'node_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NodeInfoResponse {
  /// Represents a response from the node_info endpoint from the blockchain.
  NodeInfoResponse({
    required this.nodeInfo,
    required this.applicationVersion,
  });

  final NodeInfo nodeInfo;
  final NodeInfoApplicationVersion applicationVersion;

  factory NodeInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$NodeInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NodeInfoResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NodeInfo {
  /// Represents a response from the node_info endpoint from the blockchain.
  NodeInfo({
    required this.protocolVersion,
    required this.id,
    required this.listenAddr,
    required this.network,
    required this.version,
    required this.channels,
    required this.moniker,
    required this.other,
  });

  final NodeInfoProtocolVersion protocolVersion;
  final String id;
  final Uri listenAddr;
  final String network;
  final String version;
  final String channels;
  final String moniker;
  final NodeInfoOther other;

  factory NodeInfo.fromJson(Map<String, dynamic> json) =>
      _$NodeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$NodeInfoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NodeInfoProtocolVersion {
  /// Represents a response from the node_info endpoint from the blockchain.
  NodeInfoProtocolVersion({
    this.p2p,
    this.block,
    this.app,
  });

  final String? p2p;
  final String? block;
  final String? app;

  factory NodeInfoProtocolVersion.fromJson(Map<String, dynamic> json) =>
      _$NodeInfoProtocolVersionFromJson(json);

  Map<String, dynamic> toJson() => _$NodeInfoProtocolVersionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NodeInfoOther {
  /// Represents a response from the node_info endpoint from the blockchain.
  NodeInfoOther({
    this.txIndex,
    this.rpcAddress,
  });

  final String? txIndex;
  final Uri? rpcAddress;

  factory NodeInfoOther.fromJson(Map<String, dynamic> json) =>
      _$NodeInfoOtherFromJson(json);

  Map<String, dynamic> toJson() => _$NodeInfoOtherToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NodeInfoApplicationVersion {
  /// Represents a response from the node_info endpoint from the blockchain.
  NodeInfoApplicationVersion({
    required this.version,
    this.name,
    this.serverName,
    this.clientName,
    this.commit,
    this.buildTags,
    this.go,
    this.buildDeps,
  });

  final String? name;
  final String? serverName;
  final String? clientName;
  final String version;
  final String? commit;
  final String? buildTags;
  final String? go;
  final List<String>? buildDeps;

  factory NodeInfoApplicationVersion.fromJson(Map<String, dynamic> json) =>
      _$NodeInfoApplicationVersionFromJson(json);

  Map<String, dynamic> toJson() => _$NodeInfoApplicationVersionToJson(this);
}
