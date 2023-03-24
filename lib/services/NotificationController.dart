import 'dart:async';
import 'dart:io';

import 'package:acc_manager/services/LocalStreams.dart';

import '../main.dart';

class NotificationController {
  static final NotificationController _singleton =
      new NotificationController._internal();

  StreamController<String> streamController =
      new StreamController.broadcast(sync: true);

  String wsUrl = 'ws://${conf.serverIP}:${conf.serverPort}/acc/mobileStats';

  late WebSocket channel;
  late StreamSubscription<dynamic> subscription;
  static bool firstTimeSubscription = true;
  bool autoReconnect = true;

  factory NotificationController() {
    return _singleton;
  }

  NotificationController._internal() {
    initWebSocketConnection();
  }

  closeConnection() async {
    this.subscription.cancel();
    this.channel.close();
    autoReconnect = false;
  }

  initWebSocketConnection() async {
    print("conecting...");
    this.channel = await connectWs();
    print("socket connection initializied");
    LocalStreams.controllerLocal.add(true);
    this.channel.done.then((dynamic _) => _onDisconnected());
    broadcastNotifications();
    autoReconnect = true;
  }

  broadcastNotifications() {
    subscription = this.channel.asBroadcastStream().listen((streamData) {
      streamController.add(streamData);
      LocalStreams.controllerLocal.add(true);
    }, onDone: () {
      print("connecting aborted");
      LocalStreams.controllerLocal.add(false);
      initWebSocketConnection();
    }, onError: (e) {
      print('Server error: $e');
      LocalStreams.controllerLocal.add(false);
      initWebSocketConnection();
    });
  }

  connectWs() async {
    try {
      print("Connect WS connectWs " + wsUrl);
      return await WebSocket.connect(wsUrl);
    } catch (e) {
      print("Error! can not connect WS connectWs " + e.toString());
      await Future.delayed(Duration(milliseconds: 3000));
      LocalStreams.controllerLocal.add(false);
      return await connectWs();
    }
  }

  void _onDisconnected() {
    LocalStreams.controllerLocal.add(false);
    if (autoReconnect) initWebSocketConnection();
  }

  void reconnect() {
    if (!firstTimeSubscription) {
      print("reconecting...");
      //broadcastNotifications();
      subscription.resume();
    }
    firstTimeSubscription = false;
    //broadcastNotifications();
  }
}
