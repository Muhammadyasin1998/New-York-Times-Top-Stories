import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstraction so we can mock/test network checks
abstract class INetworkInfo {
  /// Returns true if connected to internet
  Future<bool> get isConnected;


}

class NetworkInfoImpl implements INetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity();

 @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return (result.contains(ConnectivityResult.none) ) ? false : true;
  }

}
