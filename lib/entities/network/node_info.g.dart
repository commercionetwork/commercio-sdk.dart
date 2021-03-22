// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeInfoResponse _$NodeInfoResponseFromJson(Map<String, dynamic> json) {
  return NodeInfoResponse(
    nodeInfo: NodeInfo.fromJson(json['node_info'] as Map<String, dynamic>),
    applicationVersion: NodeInfoApplicationVersion.fromJson(
        json['application_version'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NodeInfoResponseToJson(NodeInfoResponse instance) =>
    <String, dynamic>{
      'node_info': instance.nodeInfo,
      'application_version': instance.applicationVersion,
    };

NodeInfo _$NodeInfoFromJson(Map<String, dynamic> json) {
  return NodeInfo(
    protocolVersion: NodeInfoProtocolVersion.fromJson(
        json['protocol_version'] as Map<String, dynamic>),
    id: json['id'] as String,
    listenAddr: Uri.parse(json['listen_addr'] as String),
    network: json['network'] as String,
    version: json['version'] as String,
    channels: json['channels'] as String,
    moniker: json['moniker'] as String,
    other: NodeInfoOther.fromJson(json['other'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NodeInfoToJson(NodeInfo instance) => <String, dynamic>{
      'protocol_version': instance.protocolVersion,
      'id': instance.id,
      'listen_addr': instance.listenAddr.toString(),
      'network': instance.network,
      'version': instance.version,
      'channels': instance.channels,
      'moniker': instance.moniker,
      'other': instance.other,
    };

NodeInfoProtocolVersion _$NodeInfoProtocolVersionFromJson(
    Map<String, dynamic> json) {
  return NodeInfoProtocolVersion(
    p2p: json['p2p'] as String?,
    block: json['block'] as String?,
    app: json['app'] as String?,
  );
}

Map<String, dynamic> _$NodeInfoProtocolVersionToJson(
        NodeInfoProtocolVersion instance) =>
    <String, dynamic>{
      'p2p': instance.p2p,
      'block': instance.block,
      'app': instance.app,
    };

NodeInfoOther _$NodeInfoOtherFromJson(Map<String, dynamic> json) {
  return NodeInfoOther(
    txIndex: json['tx_index'] as String?,
    rpcAddress: json['rpc_address'] == null
        ? null
        : Uri.parse(json['rpc_address'] as String),
  );
}

Map<String, dynamic> _$NodeInfoOtherToJson(NodeInfoOther instance) =>
    <String, dynamic>{
      'tx_index': instance.txIndex,
      'rpc_address': instance.rpcAddress?.toString(),
    };

NodeInfoApplicationVersion _$NodeInfoApplicationVersionFromJson(
    Map<String, dynamic> json) {
  return NodeInfoApplicationVersion(
    version: json['version'] as String,
    name: json['name'] as String?,
    serverName: json['server_name'] as String?,
    clientName: json['client_name'] as String?,
    commit: json['commit'] as String?,
    buildTags: json['build_tags'] as String?,
    go: json['go'] as String?,
    buildDeps: (json['build_deps'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$NodeInfoApplicationVersionToJson(
        NodeInfoApplicationVersion instance) =>
    <String, dynamic>{
      'name': instance.name,
      'server_name': instance.serverName,
      'client_name': instance.clientName,
      'version': instance.version,
      'commit': instance.commit,
      'build_tags': instance.buildTags,
      'go': instance.go,
      'build_deps': instance.buildDeps,
    };
