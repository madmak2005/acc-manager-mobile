class StatLap {
  int lapNo;
  bool fromPit;
  bool toPit;
  int lapTime;
  double distanceTraveled;
  SplitTimes splitTimes;
  double fuelAdded;
  double fuelUsed;
  double fuelLeftOnStart;
  double fuelLeftOnEnd;
  double fuelAVGPerMinute;
  double fuelXlap;
  Maps maps;
  int rainTyres;
  bool isValidLap;
  bool first;
  bool last;
  double sessionTimeLeft;
  double pFL;
  double pFR;
  double pRL;
  double pRR;
  double tFL;
  double tFR;
  double tRL;
  double tRR;
  double airTemp;
  double roadTemp;
  double fuelNTFOnEnd;
  //double fuelEFNMinutesOnEnd;
  double fuelEFNLapsOnEnd;
  double fuelAVGPerLap;
  double clockAtStart;
  double rainIntensity;
  double trackGripStatus;
  String trackStatus;
  double fuelEstForNextMiliseconds;

  StatLap(
      {this.lapNo,
        this.fromPit,
        this.toPit,
        this.lapTime,
        this.distanceTraveled,
        this.splitTimes,
        this.fuelAdded,
        this.fuelUsed,
        this.fuelLeftOnStart,
        this.fuelLeftOnEnd,
        this.fuelAVGPerMinute,
        this.fuelXlap,
        this.maps,
        this.rainTyres,
        this.isValidLap,
        this.first,
        this.last,
        this.sessionTimeLeft,
        this.pFL,
        this.pFR,
        this.pRL,
        this.pRR,
        this.tFL,
        this.tFR,
        this.tRL,
        this.tRR,
        this.airTemp,
        this.roadTemp,
        this.fuelNTFOnEnd,
        //this.fuelEFNMinutesOnEnd,
        this.fuelEFNLapsOnEnd,
        this.fuelAVGPerLap,
        this.clockAtStart,
        this.rainIntensity,
        this.trackGripStatus,
        this.trackStatus,
        this.fuelEstForNextMiliseconds});

  StatLap.fromJson(Map<String, dynamic> json) {
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
    fuelEstForNextMiliseconds = json['fuelEstForNextMiliseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lapNo'] = this.lapNo;
    data['fromPit'] = this.fromPit;
    data['toPit'] = this.toPit;
    data['lapTime'] = this.lapTime;
    data['distanceTraveled'] = this.distanceTraveled;
    if (this.splitTimes != null) {
      data['splitTimes'] = this.splitTimes.toJson();
    }
    data['fuelAdded'] = this.fuelAdded;
    data['fuelUsed'] = this.fuelUsed;
    data['fuelLeftOnStart'] = this.fuelLeftOnStart;
    data['fuelLeftOnEnd'] = this.fuelLeftOnEnd;
    data['fuelAVGPerMinute'] = this.fuelAVGPerMinute;
    data['fuelXlap'] = this.fuelXlap;
    if (this.maps != null) {
      data['maps'] = this.maps.toJson();
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
    data['fuelEstForNextMiliseconds'] = this.fuelEstForNextMiliseconds;
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