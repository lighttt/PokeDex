import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<ConnectivityResult> get connectionStream;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    if (result is ConnectivityResult) {
      return result != ConnectivityResult.none;
    }
    if (result is List<ConnectivityResult>) {
      return result.any((r) => r != ConnectivityResult.none);
    }
    return false;
  }

  @override
  Stream<ConnectivityResult> get connectionStream => connectivity.onConnectivityChanged.map((results) {
        if (results is List<ConnectivityResult>) {
          return results.isNotEmpty ? results.first : ConnectivityResult.none;
        }
        return results as ConnectivityResult;
      });
}
