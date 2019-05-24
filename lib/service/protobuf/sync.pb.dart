///
//  Generated code. Do not modify.
//  source: sync.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, String;

import 'package:protobuf/protobuf.dart' as $pb;

class SyncRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SyncRequest', package: const $pb.PackageName('sync_grpc'))
    ..aOS(1, 'userId')
    ..a<$core.int>(2, 'localHead', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SyncRequest() : super();
  SyncRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SyncRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SyncRequest clone() => SyncRequest()..mergeFromMessage(this);
  SyncRequest copyWith(void Function(SyncRequest) updates) => super.copyWith((message) => updates(message as SyncRequest));
  $pb.BuilderInfo get info_ => _i;
  static SyncRequest create() => SyncRequest();
  SyncRequest createEmptyInstance() => create();
  static $pb.PbList<SyncRequest> createRepeated() => $pb.PbList<SyncRequest>();
  static SyncRequest getDefault() => _defaultInstance ??= create()..freeze();
  static SyncRequest _defaultInstance;

  $core.String get userId => $_getS(0, '');
  set userId($core.String v) { $_setString(0, v); }
  $core.bool hasUserId() => $_has(0);
  void clearUserId() => clearField(1);

  $core.int get localHead => $_get(1, 0);
  set localHead($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasLocalHead() => $_has(1);
  void clearLocalHead() => clearField(2);
}

class SyncResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SyncResponse', package: const $pb.PackageName('sync_grpc'))
    ..a<$core.int>(1, 'remoteHead', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'actionsLength', $pb.PbFieldType.O3)
    ..pPS(3, 'actions')
    ..hasRequiredFields = false
  ;

  SyncResponse() : super();
  SyncResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SyncResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SyncResponse clone() => SyncResponse()..mergeFromMessage(this);
  SyncResponse copyWith(void Function(SyncResponse) updates) => super.copyWith((message) => updates(message as SyncResponse));
  $pb.BuilderInfo get info_ => _i;
  static SyncResponse create() => SyncResponse();
  SyncResponse createEmptyInstance() => create();
  static $pb.PbList<SyncResponse> createRepeated() => $pb.PbList<SyncResponse>();
  static SyncResponse getDefault() => _defaultInstance ??= create()..freeze();
  static SyncResponse _defaultInstance;

  $core.int get remoteHead => $_get(0, 0);
  set remoteHead($core.int v) { $_setSignedInt32(0, v); }
  $core.bool hasRemoteHead() => $_has(0);
  void clearRemoteHead() => clearField(1);

  $core.int get actionsLength => $_get(1, 0);
  set actionsLength($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasActionsLength() => $_has(1);
  void clearActionsLength() => clearField(2);

  $core.List<$core.String> get actions => $_getList(2);
}

class PushRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushRequest', package: const $pb.PackageName('sync_grpc'))
    ..aOS(1, 'userId')
    ..aOS(2, 'action')
    ..aOS(3, 'contentId')
    ..hasRequiredFields = false
  ;

  PushRequest() : super();
  PushRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PushRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PushRequest clone() => PushRequest()..mergeFromMessage(this);
  PushRequest copyWith(void Function(PushRequest) updates) => super.copyWith((message) => updates(message as PushRequest));
  $pb.BuilderInfo get info_ => _i;
  static PushRequest create() => PushRequest();
  PushRequest createEmptyInstance() => create();
  static $pb.PbList<PushRequest> createRepeated() => $pb.PbList<PushRequest>();
  static PushRequest getDefault() => _defaultInstance ??= create()..freeze();
  static PushRequest _defaultInstance;

  $core.String get userId => $_getS(0, '');
  set userId($core.String v) { $_setString(0, v); }
  $core.bool hasUserId() => $_has(0);
  void clearUserId() => clearField(1);

  $core.String get action => $_getS(1, '');
  set action($core.String v) { $_setString(1, v); }
  $core.bool hasAction() => $_has(1);
  void clearAction() => clearField(2);

  $core.String get contentId => $_getS(2, '');
  set contentId($core.String v) { $_setString(2, v); }
  $core.bool hasContentId() => $_has(2);
  void clearContentId() => clearField(3);
}

class PushResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PushResponse', package: const $pb.PackageName('sync_grpc'))
    ..a<$core.int>(1, 'remoteHead', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PushResponse() : super();
  PushResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PushResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PushResponse clone() => PushResponse()..mergeFromMessage(this);
  PushResponse copyWith(void Function(PushResponse) updates) => super.copyWith((message) => updates(message as PushResponse));
  $pb.BuilderInfo get info_ => _i;
  static PushResponse create() => PushResponse();
  PushResponse createEmptyInstance() => create();
  static $pb.PbList<PushResponse> createRepeated() => $pb.PbList<PushResponse>();
  static PushResponse getDefault() => _defaultInstance ??= create()..freeze();
  static PushResponse _defaultInstance;

  $core.int get remoteHead => $_get(0, 0);
  set remoteHead($core.int v) { $_setSignedInt32(0, v); }
  $core.bool hasRemoteHead() => $_has(0);
  void clearRemoteHead() => clearField(1);
}

