import 'package:grpc/grpc_web.dart';
import 'package:meta/meta.dart';
import 'package:sp_client/service/protobuf/connection.pbgrpc.dart';

class GrpcService {
  final String host;
  GrpcWebClientChannel _channel;

  ConnectionServiceClient connectionServiceClient;

  GrpcService({@required this.host}) {
    _channel = GrpcWebClientChannel.xhr(Uri.parse('http://$host:8002'));
    connectionServiceClient = ConnectionServiceClient(_channel);
  }
}
