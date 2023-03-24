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

  static StreamController<int> controllerImportedLaps =
      StreamController<int>.broadcast();

  static StreamController<int> controllerUnsentLapsToGoogle =
      StreamController<int>.broadcast();

  static StreamController<bool> controllerLocal =
      StreamController<bool>.broadcast();
  static StreamController<bool> controllerGoogle =
      StreamController<bool>.broadcast();

  static StreamController<bool> controllerLapsToSend =
      StreamController<bool>.broadcast();

  static StreamController<bool> controllerBackToHomePage =
      StreamController<bool>.broadcast();
  static Stream streamBackToHomePage =
      LocalStreams.controllerBackToHomePage.stream;

  static bool streamLapsToSendActive = false;
  static Stream streamLocal = controllerLocal.stream;
  static Stream streamGoogle = controllerGoogle.stream;
  static Stream streamLapsToSend = controllerLapsToSend.stream;
  static Stream streamImportedLaps = controllerImportedLaps.stream;
  static Stream streamUnsentLapsToGoogle = controllerUnsentLapsToGoogle.stream;

  static bool localStream = false;
  static bool googleStream = false;
  static bool googleStreamActivated = false;

  static List<StatSession> stat_sessions = [];
  static List<StatMobile> stat_laps = [];

  static List<StatMobile> allLapsFromACCManagerServer = [];
  static List<StatMobile> allLapsToBeSendToGoogle = [];

  static List<StatMobile> lapsToBeSendToACCManagerServer = [];
  static List<String> importedLapsfromGoogleIds = [];

  static ListQueue<StatMobile> avg3Laps = new ListQueue(3);
  static ListQueue<StatMobile> avg5Laps = new ListQueue(5);

  static Stream<QuerySnapshot<Object?>>? channelReadFirebase;

  static String vteam = "";
  static String vpin = "";

  static int internalSessionIndex = 0;

  LocalStreams(BuildContext context) {
    LocalStreams.context = context;
  }

  static void resendStatuses() {
    controllerLocal.add(localStream);
    controllerGoogle.add(googleStream);
  }

  static late StreamSubscription<String> notContoller;
  //static late var _streamController =   new NotificationController().streamController;
  static void downloadEnduranceLaps(String team, String passwd) {
    var oneTimeCollection =
        context.read<ChatProvider>().getChatCollection('${team}:${passwd}');
    int i = 0;
    oneTimeCollection.then((value) => {
          value.docs.forEach((element) {
            MessageChat sm = MessageChat.fromDocument(element);

            StatMobile lap =
                StatMobile.fromJson(json.decode(sm.content.toString()));
            lap.teamCode = team;
            lap.pin = passwd;
            lap.docId = int.parse(sm.timestamp);
            log("[" +
                lap.internalLapIndex.toString() +
                "] importing " +
                (++i).toString() +
                '/' +
                value.docs.length.toString());
            if (!importedLapsfromGoogleIds.contains(sm.timestamp)) {
              importedLapsfromGoogleIds.add(sm.timestamp);
              controllerImportedLaps.add(i);
              _addLap(lap);
            }
          })
        });
    controllerLapsToSend.add(true);
  }

  static void initChannels(String team, String passwd) {
    channelReadFirebase =
        context.read<ChatProvider>().getChatStream('${team}:${passwd}', 1);

    var oneTimeCollection =
        context.read<ChatProvider>().getChatCollection('${team}:${passwd}');

    List<QueryDocumentSnapshot> listMessage = [];
    log('onTimeCollection.then');
    int i = 0;
    oneTimeCollection.then((value) => {
          value.docs.forEach((element) {
            MessageChat sm = MessageChat.fromDocument(element);
            StatMobile lap =
                StatMobile.fromJson(json.decode(sm.content.toString()));
            lap.teamCode = team;
            lap.pin = passwd;
            lap.docId = int.parse(sm.timestamp);
            log("[" +
                lap.internalLapIndex.toString() +
                "] importing " +
                (++i).toString() +
                '/' +
                value.docs.length.toString());
            if (!importedLapsfromGoogleIds.contains(sm.timestamp)) {
              importedLapsfromGoogleIds.add(sm.timestamp);
              controllerImportedLaps.add(i);
              _addLap(lap);
            }
            controllerLapsToSend.add(true);
          })
        });

    oneTimeCollection.whenComplete(() => {
          googleSubscription = channelReadFirebase!.asBroadcastStream().listen(
            (data) {
              log("subscribe to stream");
              print(data.toString());
              listMessage = data.docs;
              listMessage.forEach((element) {
                log('SENDING TO ACC SERVER MANAGER');
                MessageChat sm = MessageChat.fromDocument(element);
                StatMobile lap =
                    StatMobile.fromJson(json.decode(sm.content.toString()));
                lap.teamCode = vteam;
                lap.pin = vpin;
                lap.docId = int.parse(sm.timestamp);
                _addLap(lap);
                controllerLapsToSend.add(true);
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

  static void initLocalStreamLapsToSend() {
    if (!localStream) {
      log("initLocalStreamLapsToSend");
      notContoller =
          new NotificationController().streamController.stream.listen(
        (data) {
          var statM = StatMobile.fromJson(json.decode(data as String));
          var index = allLapsFromACCManagerServer.indexWhere((element) =>
              (element.clockAtStart == statM.clockAtStart &&
                  element.lapNo == statM.lapNo &&
                  element.lapTime == statM.lapTime));
          if (index == -1) allLapsFromACCManagerServer.add(statM);

          index = allLapsToBeSendToGoogle.indexWhere((element) =>
              (element.clockAtStart == statM.clockAtStart &&
                  element.lapNo == statM.lapNo &&
                  element.lapTime == statM.lapTime));
          if (index == -1) allLapsToBeSendToGoogle.add(statM);
          localStream = true;
          controllerLocal.add(localStream);
          if (googleStream) sendUnsendLapsToGoogle();
          controllerUnsentLapsToGoogle.add(allLapsToBeSendToGoogle.length);
        },
      );
    }
    localStreamLapsToSend();
  }

  static localStreamLapsToSend() {
    if (!streamLapsToSendActive) {
      log("initLocalStreamLapsToSend");
      streamLapsToSend.listen((event) {
        log("initLocalStreamLapsToSend event:" + event.toString());
        List<StatMobile> lapsToRemove = [];
        lapsToBeSendToACCManagerServer.forEach((lap) {
          String content = json.encode(lap);
          //var content = lap.toJson().toString();
          var ret = RESTSessions.importTeamLap(content);
          ret
              .then((value) => lapsToRemove.add(lap))
              .onError((error, stackTrace) => log(error.toString()));
        });
        lapsToRemove.forEach((element) {
          lapsToBeSendToACCManagerServer.remove(element);
        });
      });
      streamLapsToSendActive = true;
    }
  }

  static sendUnsendLapsToGoogle() {
    List<StatMobile> toRemove = [];
    for (var lapToSend in allLapsToBeSendToGoogle) {
      String c = json.encode(lapToSend);
      var success = _send(c, '$vteam:$vpin', lapToSend.driverName);
      if (success) {
        toRemove.add(lapToSend);
      }
    }
    for (var lapToRemove in toRemove) {
      allLapsToBeSendToGoogle.remove(lapToRemove);
    }
    controllerUnsentLapsToGoogle.add(allLapsToBeSendToGoogle.length);
  }

  static void initGoogleStreams(String team, String passwd) {
    log("initGoogleStreams");
    stat_sessions.clear();
    NotificationController().reconnect();
    vteam = team;
    vpin = passwd;
  }

  static void _addLap(StatMobile lap) {
    bool haveSession = false;
    if (stat_sessions.length > 0) {
      stat_sessions.forEach((session) {
        if (session.car.carModel == lap.carModel &&
            session.car.track == lap.track &&
            session.session_TYPENAME == lap.session_TYPE) {
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
      session.internalSessionIndex = internalSessionIndex++;
      session.car.carModel = lap.carModel;
      session.car.track = lap.track;
      session.car.playerName = lap.driverName;
      session.fuelAVG3Laps = lap.fuelXlap;
      session.fuelAVG5Laps = lap.fuelXlap;
      session.fuelXLap = lap.fuelXlap;
      session.avgLapTime3 = lap.lapTime;
      session.avgLapTime5 = lap.lapTime;
      session.driverSet.add(lap.driverName);
      session.session_TYPENAME = lap.session_TYPE;
      switch (lap.session_TYPE) {
        case "QUALIFY":
          session.sessionTYPE = 1;
          break;
        case "PRACTICE":
          session.sessionTYPE = 0;
          break;
        case "RACE":
          session.sessionTYPE = 2;
          break;
        case "HOTLAP":
          session.sessionTYPE = 3;
          break;
        case "TIME_ATTACK":
          session.sessionTYPE = 4;
          break;
        case "HOTSTINT":
          session.sessionTYPE = 7;
          break;
        case "HOTLAPSUPERPOLE":
          session.sessionTYPE = 8;
          break;
      }

      session.laps.add(lap);
      stat_sessions.add(session);
    }
    lapsToBeSendToACCManagerServer.add(lap);
  }

  static bool _send(String content, String chatID, String peerId) {
    //super.initState();
    var chatProvider = context.read<ChatProvider>();
    var authProvider = context.read<AuthProvider>();
    var success = false;
    if (!sentLaps.contains(content)) {
      log("sending message");
      success = chatProvider.sendMessage(
          content,
          1,
          chatID,
          authProvider.getUserFirebaseId() == null
              ? ""
              : authProvider.getUserFirebaseId()!,
          peerId);
      if (success) sentLaps.add(content);
    } else {
      log("not sending message, already sent");
      success = true;
    }
    return success;
  }

  static void stopGoogleStream() {
    if (googleSubscription != null) {
      googleSubscription!.cancel();
      channelReadFirebase = null;
      googleStream = false;
      controllerGoogle.add(googleStream);
    }
  }

  static void stopACCStream() {
    //channelMobileStats.sink.close();
    localStream = false;
    controllerLocal.add(localStream);
    //_streamController.sink.close();
    //_streamController.close();
    NotificationController().closeConnection();
    notContoller.cancel();
    log('ACC Stream disconnected');
  }

  static void startACCStream() {
    NotificationController().initWebSocketConnection();
    initLocalStreamLapsToSend();
  }

  static void sendUnsentEnduranceLaps(String team, String passwd) {
    vteam = team;
    vpin = passwd;
    sendUnsendLapsToGoogle();
  }
}
