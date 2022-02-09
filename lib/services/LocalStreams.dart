import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:acc_manager/common/StatLap.dart';
import 'package:acc_manager/common/StatMobile.dart';
import 'package:acc_manager/common/StatSession.dart';
import 'package:acc_manager/models/message_chat.dart';
import 'package:acc_manager/providers/providers.dart';
import 'package:acc_manager/services/RESTSessions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:acc_manager/main.dart';
import 'package:web_socket_channel/io.dart';

import 'NotificationController.dart';

class LocalStreams {
  static late BuildContext context;
  //static var channelMobileStats = IOWebSocketChannel.connect(
  //    Uri.parse('ws://${conf.serverIP}:${conf.serverPort}/acc/mobileStats'));

  static StreamSubscription<QuerySnapshot<Object?>>? googleSubscription;
  static StreamSubscription<QuerySnapshot<Object?>>? googleSubscription500;
  static StreamController<bool> controllerLocal =
      StreamController<bool>.broadcast();
  static StreamController<bool> controllerGoogle =
      StreamController<bool>.broadcast();

  static StreamController<bool> controllerLapsToSend =
      StreamController<bool>.broadcast();

  static Stream streamLocal = LocalStreams.controllerLocal.stream;
  static Stream streamGoogle = LocalStreams.controllerGoogle.stream;
  static Stream streamLapsToSend = LocalStreams.controllerLapsToSend.stream;

  static bool localStream = false;
  static bool googleStream = false;

  static List<StatSession> stat_sessions = [];
  static List<StatMobile> stat_laps = [];

  static List<StatMobile> lapsToSend = [];

  static ListQueue<StatMobile> avg3Laps = new ListQueue(3);
  static ListQueue<StatMobile> avg5Laps = new ListQueue(5);

  static Stream<QuerySnapshot<Object?>>? channelReadFirebase;

  static String vteam = "";
  static String vpin = "";

  LocalStreams(BuildContext context) {
    LocalStreams.context = context;
  }

  static void resendStatuses() {
    controllerLocal.add(localStream);
    controllerGoogle.add(googleStream);
  }

  static late StreamSubscription<String> notContoller;
  //static late var _streamController =   new NotificationController().streamController;

  static void initStreams(String team, String passwd) {
    vteam = team;
    vpin = passwd;
    stat_sessions.clear();
    NotificationController().reconnect();
    //var _streamController = new NotificationController().streamController;
    notContoller = new NotificationController().streamController.stream.listen(
      (data) {
        //print(data);
        var statM = StatMobile.fromJson(json.decode(data as String));
        _send(data.toString(), '${team}:${passwd}', statM.driverName);
        localStream = true;
        controllerLocal.add(localStream);
      },
    );

    streamLapsToSend.listen((event) {
      List<StatMobile> lapsToRemove = [];
      lapsToSend.forEach((lap) {
        String content = json.encode(lap);
        //var content = lap.toJson().toString();
        RESTSessions.importTeamLap(content);
        lapsToRemove.add(lap);
      });
      lapsToRemove.forEach((element) {
        lapsToSend.remove(element);
      });
    });
    /*
        onError: (error) => () {
              _streamController.sink.close();
            },
        onDone: () => () {
              _streamController.sink.close();
            });
    */
    /*
    channelMobileStats.sink.close();
    channelMobileStats = IOWebSocketChannel.connect(
        Uri.parse('ws://${conf.serverIP}:${conf.serverPort}/acc/mobileStats'));

    channelMobileStats.stream.listen((data) {
      print(data);
      var statM = StatMobile.fromJson(json.decode(data as String));
      _send(data.toString(), '${team}:${passwd}', statM.driverName);
      localStream = true;
      controllerLocal.add(localStream);
    },
        onError: (error) => () {
              print(error);
              localStream = false;
              controllerLocal.add(localStream);
            });
    */
    channelReadFirebase =
        context.read<ChatProvider>().getChatStream('${team}:${passwd}', 1);

    var onTimeCollection =
        context.read<ChatProvider>().getChatCollection('${team}:${passwd}');

    List<QueryDocumentSnapshot> listMessage = [];
    log('onTimeCollection.then');
    int i = 0;
    onTimeCollection.then((value) => {
          value.docs.forEach((element) {
            MessageChat sm = MessageChat.fromDocument(element);
            StatMobile lap =
                StatMobile.fromJson(json.decode(sm.content.toString()));
            lap.teamCode = vteam;
            lap.pin = vpin;
            log("importing " +
                (++i).toString() +
                '/' +
                value.docs.length.toString());
            _addLap(lap);
            controllerLapsToSend.add(true);
          })
        });

    onTimeCollection.whenComplete(() => {
          googleSubscription = channelReadFirebase!.asBroadcastStream().listen(
            (data) {
              log("subscribe to stream");
              print(data.toString());
              listMessage = data.docs;
              listMessage.forEach((element) {
                //log(element.data().toString());
                log('SENDING TO ACC SERVER MANAGER');
                MessageChat sm = MessageChat.fromDocument(element);
                //log(sm.content);
                StatMobile lap =
                    StatMobile.fromJson(json.decode(sm.content.toString()));
                lap.teamCode = vteam;
                lap.pin = vpin;
                _addLap(lap);
                controllerLapsToSend.add(true);
                /*
                String c = json.encode(lap);
                //log(c);
                log(lap.driverName);

                sm.content = c;
                try {
                  RESTSessions.importTeamLap(sm.content)
                      .then((value) => print(sm.idFrom));
                } on RESTSessions catch (e) {
                  print('error caught: $e');
                }
                */
              });

              googleStream = true;
              controllerGoogle.add(googleStream);
            },
            onError: (error) => () {
              print(error);
              googleSubscription!.cancel();
              channelReadFirebase = null;
              googleStream = false;
              controllerGoogle.add(googleStream);
            },
          )
        });
  }

  static void _addLap(StatMobile lap) {
    bool haveSession = false;
    if (stat_sessions.length > 0) {
      stat_sessions.forEach((session) {
        if (session.internalSessionIndex == lap.internalSessionIndex) {
          haveSession = true;

          if (lap.isValidLap) {
            avg3Laps.add(lap);
            avg5Laps.add(lap);
          }

          double avg3 = 0;
          double avg5 = 0;
          double avg3t = 0.0;
          double avg5t = 0.0;

          avg3Laps.forEach((element) {
            avg3 += element.fuelXlap;
            avg3t += element.lapTime;
          });
          avg5Laps.forEach((element) {
            avg5 += element.fuelXlap;
            avg5t += element.lapTime;
          });

          if (avg3Laps.length > 0) {
            avg3 = avg3 / avg3Laps.length;
            avg3t = avg3t / avg3Laps.length;
          }
          if (avg5Laps.length > 0) {
            avg5 = avg5 / avg5Laps.length;
            avg5t = avg5t / avg5Laps.length;
          }

          session.fuelAVG3Laps = avg3;
          session.fuelAVG5Laps = avg5;
          session.fuelXLap = lap.fuelXlap;
          session.avgLapTime3 = avg3t.round();
          session.avgLapTime5 = avg5t.round();
          session.driverSet.add(lap.driverName);
          session.session_TYPENAME = lap.session_TYPE;
          session.laps.add(lap);
        }
      });
    }
    if (!haveSession) {
      StatSession session = new StatSession();
      avg3Laps.clear();
      avg5Laps.clear();
      session.internalSessionIndex = lap.internalSessionIndex;
      session.car.carModel = lap.carModel;
      session.car.track = lap.track;
      session.car.playerName = lap.driverName;
      session.fuelAVG3Laps = lap.fuelXlap;
      session.fuelAVG5Laps = lap.fuelXlap;
      session.fuelXLap = lap.fuelXlap;
      session.avgLapTime3 = lap.lapTime;
      session.avgLapTime5 = lap.lapTime;
      session.driverSet.add(lap.driverName);
      session.laps.add(lap);
      stat_sessions.add(session);
    }
    lapsToSend.add(lap);
  }

  static void _send(String content, String chatID, String peerId) {
    //super.initState();
    var chatProvider = context.read<ChatProvider>();
    var authProvider = context.read<AuthProvider>();

    if (!sentLaps.contains(content)) {
      log("sending message");
      chatProvider.sendMessage(
          content,
          1,
          chatID,
          authProvider.getUserFirebaseId() == null
              ? ""
              : authProvider.getUserFirebaseId()!,
          peerId);
      sentLaps.add(content);
    } else {
      log("not sending message, already sent");
    }
  }

  static void stopStreams() {
    //channelMobileStats.sink.close();
    localStream = false;
    controllerLocal.add(localStream);
    //_streamController.sink.close();
    //_streamController.close();
    NotificationController().closeConnection();
    notContoller.cancel();
    if (googleSubscription != null) {
      googleSubscription!.cancel();
      channelReadFirebase = null;
      googleStream = false;
      controllerGoogle.add(googleStream);
    }
  }
}
