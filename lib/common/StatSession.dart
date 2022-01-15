import 'package:acc_manager/common/StatMobile.dart';

import 'StatLap.dart';
import 'StatCar.dart';

class StatSession {
  StatSession();

  int sessionTYPE = 0;

  String session_TYPENAME = "";
  List<StatMobile> laps = [];
  List<StatLap> last3Laps = [];
  List<StatLap> last5Laps = [];

  StatLap? bestLap;
  StatLap? lastLap;
  StatLap? currentLap;

  double fuelNTFOnEnd = 0.0;

  StatCar car = new StatCar(
      carModel: "",
      maxFuel: 0,
      playerName: "",
      playerNick: "",
      playerSurname: "",
      sectorCount: 0,
      track: "");

  int sessionIndex = 0;
  int internalSessionIndex = 0;
  bool wasGreenFlag = false;

  int iBestTime = 0;
  int internalLapIndex = 0;

  double sessionTimeLeft = 0.0;

  double distanceTraveled = 0.0;
  double fuelAVG3Laps = 0.0;
  double fuelAVG5Laps = 0.0;
  double fuelXLap = 0.0;

  int avgLapTime3 = 0;
  int avgLapTime5 = 0;

  int packetDelta = 0;

  int? fuelEstForNextMiliseconds = 0;

  Set<String> driverSet = {};
/*
  double fuelEFNMinutesOnEnd;
  double fuelEFNLapsOnEnd;
  double fuelAVGPerLap;
 */

  StatSession.name(
      this.sessionTYPE,
      this.session_TYPENAME,
      this.laps,
      this.last3Laps,
      this.last5Laps,
      this.bestLap,
      this.lastLap,
      this.currentLap,
      this.car,
      this.sessionIndex,
      this.internalSessionIndex,
      this.wasGreenFlag,
      this.iBestTime,
      this.internalLapIndex,
      this.sessionTimeLeft,
      this.distanceTraveled,
      this.fuelAVG3Laps,
      this.fuelAVG5Laps,
      this.fuelXLap,
      this.avgLapTime3,
      this.avgLapTime5,
      this.fuelNTFOnEnd,
      this.packetDelta,
      this.fuelEstForNextMiliseconds);

  StatSession.fromJson(Map<String, dynamic> json) {
    sessionTYPE = json['session_TYPE'];
    session_TYPENAME = json['session_TYPENAME'];
    if (json['laps'] != null) {
      laps = <StatMobile>[];
      json['laps'].forEach((v) {
        laps.add(new StatMobile.fromJson(v));
      });
    }
    if (json['last3Laps'] != null) {
      last3Laps = <StatLap>[];
      json['last3Laps'].forEach((v) {
        last3Laps.add(new StatLap.fromJson(v));
      });
    }
    if (json['last5Laps'] != null) {
      last5Laps = <StatLap>[];
      json['last5Laps'].forEach((v) {
        last5Laps.add(new StatLap.fromJson(v));
      });
    }
    if (json['bestLap'] != null)
      bestLap = new StatLap.fromJson(json['bestLap']);
    if (json['lastLap'] != null)
      lastLap = new StatLap.fromJson(json['lastLap']);
    if (json['currentLap'] != null)
      currentLap = new StatLap.fromJson(json['currentLap']);
    car = new StatCar.fromJson(json['car']);
    sessionIndex = json['sessionIndex'];
    internalSessionIndex = json['internalSessionIndex'];
    wasGreenFlag = json['wasGreenFlag'];
    iBestTime = json['iBestTime'];
    internalLapIndex = json['internalLapIndex'];
    sessionTimeLeft = json['sessionTimeLeft'];
    distanceTraveled = json['distanceTraveled'];
    fuelAVG3Laps = json['fuelAVG3Laps'];
    fuelAVG5Laps = json['fuelAVG5Laps'];
    fuelXLap = json['fuelXLap'];
    avgLapTime3 = json['avgLapTime3'];
    avgLapTime5 = json['avgLapTime5'];
    packetDelta = json['packetDelta'];
    fuelEstForNextMiliseconds = json['fuelEstForNextMiliseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_TYPE'] = this.sessionTYPE;
    data['session_TYPENAME'] = this.session_TYPENAME;
    data['laps'] = this.laps.map((v) => v.toJson()).toList();
    data['last3Laps'] = this.last3Laps.map((v) => v.toJson()).toList();
    data['last5Laps'] = this.last5Laps.map((v) => v.toJson()).toList();
    if (this.bestLap != null) {
      data['bestLap'] = this.bestLap!.toJson();
    }
    if (this.lastLap != null) {
      data['lastLap'] = this.lastLap!.toJson();
    }
    if (this.currentLap != null) {
      data['currentLap'] = this.currentLap!.toJson();
    }
    data['car'] = this.car.toJson();
    data['sessionIndex'] = this.sessionIndex;
    data['internalSessionIndex'] = this.internalSessionIndex;
    data['wasGreenFlag'] = this.wasGreenFlag;
    data['iBestTime'] = this.iBestTime;
    data['sessionTimeLeft'] = this.sessionTimeLeft;
    data['distanceTraveled'] = this.distanceTraveled;
    data['fuelAVG3Laps'] = this.fuelAVG3Laps;
    data['fuelAVG5Laps'] = this.fuelAVG5Laps;
    data['avgLapTime3'] = this.avgLapTime3;
    data['avgLapTime5'] = this.avgLapTime5;
    data['packetDelta'] = this.packetDelta;
    data['fuelEstForNextMiliseconds'] = this.fuelEstForNextMiliseconds;

    return data;
  }
}

class Laps {
  Laps.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
