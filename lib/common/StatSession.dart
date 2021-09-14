import 'StatLap.dart';
import 'StatCar.dart';

class StatSession {
  int sessionTYPE;
  Laps laps;
  List<StatLap> last3Laps = [];
  List<StatLap> last5Laps = [];

  StatLap bestLap;
  StatLap lastLap;
  StatLap currentLap;

  double fuelNTFOnEnd;

  StatCar car;

  int sessionIndex;
  int internalSessionIndex;
  bool wasGreenFlag;

  int bestTime;

  double sessionTimeLeft;

  double distanceTraveled;
  double fuelAVG3Laps;
  double fuelAVG5Laps;

  int avgLapTime3;
  int avgLapTime5;

  int packetDelta;

  int fuelEstForNextMiliseconds;
/*
  double fuelEFNMinutesOnEnd;
  double fuelEFNLapsOnEnd;
  double fuelAVGPerLap;
 */

  StatSession.name(
      this.sessionTYPE,
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
      this.bestTime,
      this.sessionTimeLeft,
      this.distanceTraveled,
      this.fuelAVG3Laps,
      this.fuelAVG5Laps,
      this.avgLapTime3,
      this.avgLapTime5,
      this.fuelNTFOnEnd,
      this.packetDelta,
      this.fuelEstForNextMiliseconds);

  StatSession.fromJson(Map<String, dynamic> json) {
    sessionTYPE = json['session_TYPE'];
    laps = json['laps'] != null ? new Laps.fromJson(json['laps']) : null;
    if (json['last3Laps'] != null) {
      last3Laps = <StatLap>[];
      json['last3Laps'].forEach((v) { last3Laps.add(new StatLap.fromJson(v)); });
    }
    if (json['last5Laps'] != null) {
      last5Laps = <StatLap>[];
      json['last5Laps'].forEach((v) { last5Laps.add(new StatLap.fromJson(v)); });
    }
    bestLap = json['bestLap'] != null ? new StatLap.fromJson(json['bestLap']) : null;
    lastLap = json['lastLap'] != null ? new StatLap.fromJson(json['lastLap']) : null;
    currentLap = json['currentLap'] != null ? new StatLap.fromJson(json['currentLap']) : null;
    car = json['car'] != null ? new StatCar.fromJson(json['car']) : null;
    sessionIndex = json['sessionIndex'];
    internalSessionIndex = json['internalSessionIndex'];
    wasGreenFlag = json['wasGreenFlag'];
    bestTime = json['bestTime'];
    sessionTimeLeft = json['sessionTimeLeft'];
    distanceTraveled = json['distanceTraveled'];
    fuelAVG3Laps = json['fuelAVG3Laps'];
    fuelAVG5Laps = json['fuelAVG5Laps'];
    avgLapTime3 = json['avgLapTime3'];
    avgLapTime5 = json['avgLapTime5'];
    packetDelta = json['packetDelta'];
    fuelEstForNextMiliseconds = json['fuelEstForNextMiliseconds'];
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_TYPE'] = this.sessionTYPE;
    if (this.laps != null) {
      data['laps'] = this.laps.toJson();
    }
    if (this.last3Laps != null) {
      data['last3Laps'] = this.last3Laps.map((v) => v.toJson()).toList();
    }
    if (this.last5Laps != null) {
      data['last5Laps'] = this.last5Laps.map((v) => v.toJson()).toList();
    }
    if (this.bestLap != null) {
      data['bestLap'] = this.bestLap.toJson();
    }
    if (this.lastLap != null) {
      data['lastLap'] = this.lastLap.toJson();
    }
    if (this.currentLap != null) {
      data['currentLap'] = this.currentLap.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car.toJson();
    }
    data['sessionIndex'] = this.sessionIndex;
    data['internalSessionIndex'] = this.internalSessionIndex;
    data['wasGreenFlag'] = this.wasGreenFlag;
    data['bestTime'] = this.bestTime;
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