class StatLap {
  String teamCode = "";
  String pin = "";
  int lapNo = 0;
  bool fromPit = false;
  bool toPit = false;
  int lapTime = 0;
  double distanceTraveled = 0.0;
  SplitTimes? splitTimes;
  double fuelAdded = 0.0;
  double fuelUsed = 0.0;
  double fuelLeftOnStart = 0.0;
  double fuelLeftOnEnd = 0.0;
  double fuelAVGPerMinute = 0.0;
  double fuelXlap = 0.0;
  Maps? maps;
  int rainTyres = 0;
  bool isValidLap = false;
  bool first = false;
  bool last = false;
  double sessionTimeLeft = 0.0;
  double pFL = 0.0;
  double pFR = 0.0;
  double pRL = 0.0;
  double pRR = 0.0;
  double tFL = 0.0;
  double tFR = 0.0;
  double tRL = 0.0;
  double tRR = 0.0;
  double airTemp = 0.0;
  double roadTemp = 0.0;
  double fuelNTFOnEnd = 0.0;
  //double fuelEFNMinutesOnEnd;
  double fuelEFNLapsOnEnd = 0.0;
  double fuelAVGPerLap = 0.0;
  double clockAtStart = 0.0;
  double rainIntensity = 0.0;
  double trackGripStatus = 0.0;
  String trackStatus = "";
  String driverName = "";
  double fuelEstForNextMiliseconds = 0.0;
  int position = 0;
  int driverStintTotalTimeLeft = 0;
  int driverStintTimeLeft = 0;

  StatLap(
      {required this.teamCode,
      required this.pin,
      required this.lapNo,
      required this.fromPit,
      required this.toPit,
      required this.lapTime,
      required this.distanceTraveled,
      required this.splitTimes,
      required this.fuelAdded,
      required this.fuelUsed,
      required this.fuelLeftOnStart,
      required this.fuelLeftOnEnd,
      required this.fuelAVGPerMinute,
      required this.fuelXlap,
      required this.maps,
      required this.rainTyres,
      required this.isValidLap,
      required this.first,
      required this.last,
      required this.sessionTimeLeft,
      required this.pFL,
      required this.pFR,
      required this.pRL,
      required this.pRR,
      required this.tFL,
      required this.tFR,
      required this.tRL,
      required this.tRR,
      required this.airTemp,
      required this.roadTemp,
      required this.fuelNTFOnEnd,
      //this.fuelEFNMinutesOnEnd,
      required this.fuelEFNLapsOnEnd,
      required this.fuelAVGPerLap,
      required this.clockAtStart,
      required this.rainIntensity,
      required this.trackGripStatus,
      required this.trackStatus,
      required this.driverName,
      required this.fuelEstForNextMiliseconds,
      required this.position,
      required this.driverStintTotalTimeLeft,
      required this.driverStintTimeLeft});

  StatLap.fromJson(Map<String, dynamic> json) {
    teamCode = json['teamCode'] == null ? '' : json['teamCode'];
    pin = json['pin'] == null ? '' : json['pin'];
    lapNo = json['lapNo'];
    fromPit = json['fromPit'];
    toPit = json['toPit'];
    lapTime = json['lapTime'];
    distanceTraveled = json['distanceTraveled'];
    splitTimes = json['splitTimes'] != null
        ? new SplitTimes.fromJson(json['splitTimes'])
        : null;
    fuelAdded = json['fuelAdded'];
    fuelUsed = json['fuelUsed'];
    fuelLeftOnStart = json['fuelLeftOnStart'];
    fuelLeftOnEnd = json['fuelLeftOnEnd'];
    fuelAVGPerMinute = json['fuelAVGPerMinute'];
    fuelXlap = json['fuelXlap'];
    maps = json['maps'] != null ? new Maps.fromJson(json['maps']) : null;
    rainTyres = json['rainTyres'];
    isValidLap = json['isValidLap'];
    first = json['first'];
    last = json['last'];
    sessionTimeLeft = json['sessionTimeLeft'];
    pFL = json['pFL'] != null ? json['pFL'] : 0.0;
    pFR = json['pFR'] != null ? json['pFR'] : 0.0;
    pRL = json['pRL'] != null ? json['pRL'] : 0.0;
    pRR = json['pRR'] != null ? json['pRR'] : 0.0;
    tFL = json['tFL'] != null ? json['tFL'] : 0.0;
    tFR = json['tFR'] != null ? json['tFR'] : 0.0;
    tRL = json['tRL'] != null ? json['tRL'] : 0.0;
    tRR = json['tRR'] != null ? json['tRR'] : 0.0;
    airTemp = json['airTemp'] != null ? json['airTemp'] : 0.0;
    roadTemp = json['roadTemp'] != null ? json['roadTemp'] : 0.0;
    fuelNTFOnEnd = json['fuelNTFOnEnd'];
    //fuelEFNMinutesOnEnd = json['fuelEFNMinutesOnEnd'];
    fuelEFNLapsOnEnd = json['fuelEFNLapsOnEnd'];
    fuelAVGPerLap = json['fuelAVGPerLap'];
    clockAtStart = json['clockAtStart'];
    rainIntensity = json['rainIntensity'];
    trackGripStatus = json['trackGripStatus'];
    trackStatus = json['trackStatus'];
    driverName = json['driverName'];
    fuelEstForNextMiliseconds = json['fuelEstForNextMiliseconds'];
    position = json['position'];
    driverStintTotalTimeLeft = json['driverStintTotalTimeLeft'];
    driverStintTimeLeft = json['driverStintTimeLeft'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamCode'] = this.teamCode;
    data['pin'] = this.pin;
    data['lapNo'] = this.lapNo;
    data['fromPit'] = this.fromPit;
    data['toPit'] = this.toPit;
    data['lapTime'] = this.lapTime;
    data['distanceTraveled'] = this.distanceTraveled;
    if (this.splitTimes != null) {
      data['splitTimes'] = this.splitTimes!.toJson();
    }
    data['fuelAdded'] = this.fuelAdded;
    data['fuelUsed'] = this.fuelUsed;
    data['fuelLeftOnStart'] = this.fuelLeftOnStart;
    data['fuelLeftOnEnd'] = this.fuelLeftOnEnd;
    data['fuelAVGPerMinute'] = this.fuelAVGPerMinute;
    data['fuelXlap'] = this.fuelXlap;
    if (this.maps != null) {
      data['maps'] = this.maps!.toJson();
    }
    data['rainTyres'] = this.rainTyres;
    data['isValidLap'] = this.isValidLap;
    data['first'] = this.first;
    data['last'] = this.last;
    data['sessionTimeLeft'] = this.sessionTimeLeft;
    data['pFL'] = this.pFL;
    data['pFR'] = this.pFR;
    data['pRL'] = this.pRL;
    data['pRR'] = this.pRR;
    data['tFL'] = this.tFL;
    data['tFR'] = this.tFR;
    data['tRL'] = this.tRL;
    data['tRR'] = this.tRR;
    data['airTemp'] = this.airTemp;
    data['roadTemp'] = this.roadTemp;
    data['fuelNTFOnEnd'] = this.fuelNTFOnEnd;
    //data['fuelEFNMinutesOnEnd'] = this.fuelEFNMinutesOnEnd;
    data['fuelEFNLapsOnEnd'] = this.fuelEFNLapsOnEnd;
    data['fuelAVGPerLap'] = this.fuelAVGPerLap;
    data['clockAtStart'] = this.clockAtStart;
    data['rainIntensity'] = this.rainIntensity;
    data['trackGripStatus'] = this.trackGripStatus;
    data['trackStatus'] = this.trackStatus;
    data['driverName'] = this.driverName;
    data['fuelEstForNextMiliseconds'] = this.fuelEstForNextMiliseconds;
    data['position'] = this.position;
    data['driverStintTotalTimeLeft'] = this.driverStintTotalTimeLeft;
    data['driverStintTimeLeft'] = this.driverStintTimeLeft;
    return data;
  }
}

class Maps {
  Maps.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class SplitTimes {
  SplitTimes.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
