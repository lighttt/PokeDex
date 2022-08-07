import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<DataConnectionStatus> get connectionStream;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;
  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<DataConnectionStatus> get connectionStream => connectionChecker.onStatusChange;


}