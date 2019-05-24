///
//  Generated code. Do not modify.
//  source: sync.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:grpc/service_api.dart' as $grpc;

import 'dart:core' as $core show int, String, List;

import 'sync.pb.dart';
export 'sync.pb.dart';

class SyncServiceClient extends $grpc.Client {
  static final _$sync = $grpc.ClientMethod<SyncRequest, SyncResponse>(
      '/sync_grpc.SyncService/Sync',
      (SyncRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => SyncResponse.fromBuffer(value));
  static final _$push = $grpc.ClientMethod<PushRequest, PushResponse>(
      '/sync_grpc.SyncService/Push',
      (PushRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => PushResponse.fromBuffer(value));
  static final _$pushSequence = $grpc.ClientMethod<PushRequest, PushResponse>(
      '/sync_grpc.SyncService/PushSequence',
      (PushRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => PushResponse.fromBuffer(value));

  SyncServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseStream<SyncResponse> sync($async.Stream<SyncRequest> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$sync, request, options: options);
    return $grpc.ResponseStream(call);
  }

  $grpc.ResponseFuture<PushResponse> push(PushRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$push, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<PushResponse> pushSequence(
      $async.Stream<PushRequest> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$pushSequence, request, options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class SyncServiceBase extends $grpc.Service {
  $core.String get $name => 'sync_grpc.SyncService';

  SyncServiceBase() {
    $addMethod($grpc.ServiceMethod<SyncRequest, SyncResponse>(
        'Sync',
        sync,
        true,
        true,
        ($core.List<$core.int> value) => SyncRequest.fromBuffer(value),
        (SyncResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<PushRequest, PushResponse>(
        'Push',
        push_Pre,
        false,
        false,
        ($core.List<$core.int> value) => PushRequest.fromBuffer(value),
        (PushResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<PushRequest, PushResponse>(
        'PushSequence',
        pushSequence,
        true,
        false,
        ($core.List<$core.int> value) => PushRequest.fromBuffer(value),
        (PushResponse value) => value.writeToBuffer()));
  }

  $async.Future<PushResponse> push_Pre(
      $grpc.ServiceCall call, $async.Future request) async {
    return push(call, await request);
  }

  $async.Stream<SyncResponse> sync(
      $grpc.ServiceCall call, $async.Stream<SyncRequest> request);
  $async.Future<PushResponse> push($grpc.ServiceCall call, PushRequest request);
  $async.Future<PushResponse> pushSequence(
      $grpc.ServiceCall call, $async.Stream<PushRequest> request);
}
