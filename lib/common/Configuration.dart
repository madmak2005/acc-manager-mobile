import 'package:flutter_secure_storage/flutter_secure_storage.dart';

var serverIP = '192.168.1.111';
var serverPort = '8080';
final FlutterSecureStorage storage = FlutterSecureStorage();

class Configuration {
  static getStorage() {
    return storage;
  }

  static String getServerIP() {
    return serverIP;
  }
  static String getServerPort() {
    return serverPort;
  }
}
