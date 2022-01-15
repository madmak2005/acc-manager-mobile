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

  factory NotificationController() {
    return _singleton;
  }

  NotificationController._internal() {
    initWebSocketConnection();
  }

  closeConnection() async {
    this.subscription.cancel();
    //this.streamController.sink.close();
    //this.channel.close();
  }

  initWebSocketConnection() async {
    print("conecting...");
    this.channel = await connectWs();
    print("socket connection initializied");
    LocalStreams.controllerLocal.add(true);
    this.channel.done.then((dynamic _) => _onDisconnected());
    broadcastNotifications();
  }

  broadcastNotifications() {
    subscription = this.channel.listen((streamData) {
      streamController.add(streamData);
      LocalStreams.controllerLocal.add(true);
    }, onDone: () {
      print("conecting aborted");
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
      return await WebSocket.connect(wsUrl);
    } catch (e) {
      print("Error! can not connect WS connectWs " + e.toString());
      await Future.delayed(Duration(milliseconds: 10000));
      LocalStreams.controllerLocal.add(false);
      return await connectWs();
    }
  }

  void _onDisconnected() {
    LocalStreams.controllerLocal.add(false);
    initWebSocketConnection();
  }
}
