import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class Configuration {
  String _serverIP;
  String _serverPort;

  set serverIP(String serverIP) {
    _serverIP = serverIP;
  }
  set serverPort(String serverPort) {
    _serverPort =serverPort;
  }
  String get serverPort{
    return _serverPort;
  }

  String get serverIP{
    return _serverIP;
  }

}
