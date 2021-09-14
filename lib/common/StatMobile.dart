class StatMobile {
  int lapNo;
  bool fromPit;
  bool toPit;
  int lapTime;
  double distanceTraveled;
  SplitTimes splitTimes;
  int internalLapIndex;
  double fuelAdded;
  double fuelUsed;
  double fuelBeforePit;
  double fuelAfterPit;
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
  double avgpFL;
  double avgpFR;
  double avgpRL;
  double avgpRR;
  double avgtFL;
  double avgtFR;
  double avgtRL;
  double avgtRR;
  double avgBPFL;
  double avgBPFR;
  double avgBPRL;
  double avgBPRR;
  double avgBDFL;
  double avgBDFR;
  double avgBDRL;
  double avgBDRR;
  double avgAirTemp;
  double avgRoadTemp;
  double fuelNTFOnEnd;
  double fuelEstForNextMiliseconds;
  double fuelEFNLapsOnEnd;
  double fuelAVGPerLap;
  double clockAtStart;
  double avgRainIntensity;
  double avgTrackGripStatus;
  String trackStatus;
  String driverName;
  bool saved;
  int mfdTyreSet;
  double mfdFuelToAdd;
  double mfdTyrePressureLF;
  double mfdTyrePressureRF;
  double mfdTyrePressureLR;
  double mfdTyrePressureRR;
  int rainIntensityIn10min;
  int rainIntensityIn30min;
  int currentTyreSet;
  int strategyTyreSet;

  StatMobile(
      {this.lapNo,
        this.fromPit,
        this.toPit,
        this.lapTime,
        this.distanceTraveled,
        this.splitTimes,
        this.internalLapIndex,
        this.fuelAdded,
        this.fuelUsed,
        this.fuelBeforePit,
        this.fuelAfterPit,
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
        this.avgpFL,
        this.avgpFR,
        this.avgpRL,
        this.avgpRR,
        this.avgtFL,
        this.avgtFR,
        this.avgtRL,
        this.avgtRR,
        this.avgBPFL,
        this.avgBPFR,
        this.avgBPRL,
        this.avgBPRR,
        this.avgBDFL,
        this.avgBDFR,
        this.avgBDRL,
        this.avgBDRR,
        this.avgAirTemp,
        this.avgRoadTemp,
        this.fuelNTFOnEnd,
        this.fuelEstForNextMiliseconds,
        this.fuelEFNLapsOnEnd,
        this.fuelAVGPerLap,
        this.clockAtStart,
        this.avgRainIntensity,
        this.avgTrackGripStatus,
        this.trackStatus,
        this.driverName,
        this.saved,
        this.mfdTyreSet,
        this.mfdFuelToAdd,
        this.mfdTyrePressureLF,
        this.mfdTyrePressureRF,
        this.mfdTyrePressureLR,
        this.mfdTyrePressureRR,
        this.rainIntensityIn10min,
        this.rainIntensityIn30min,
        this.currentTyreSet,
        this.strategyTyreSet});

  StatMobile.fromJson(Map<String, dynamic> json) {
    lapNo = json['lapNo'];
    fromPit = json['fromPit'];
    toPit = json['toPit'];
    lapTime = json['lapTime'];
    distanceTraveled = json['distanceTraveled'];
    splitTimes = json['splitTimes'] != null
        ? new SplitTimes.fromJson(json['splitTimes'])
        : null;
    internalLapIndex = json['internalLapIndex'];
    fuelAdded = json['fuelAdded'];
    fuelUsed = json['fuelUsed'];
    fuelBeforePit = json['fuelBeforePit'];
    fuelAfterPit = json['fuelAfterPit'];
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
    avgpFL = json['avgpFL'];
    avgpFR = json['avgpFR'];
    avgpRL = json['avgpRL'];
    avgpRR = json['avgpRR'];
    avgtFL = json['avgtFL'];
    avgtFR = json['avgtFR'];
    avgtRL = json['avgtRL'];
    avgtRR = json['avgtRR'];
    avgBPFL = json['avgBPFL'];
    avgBPFR = json['avgBPFR'];
    avgBPRL = json['avgBPRL'];
    avgBPRR = json['avgBPRR'];
    avgBDFL = json['avgBDFL'];
    avgBDFR = json['avgBDFR'];
    avgBDRL = json['avgBDRL'];
    avgBDRR = json['avgBDRR'];
    avgAirTemp = json['avgAirTemp'];
    avgRoadTemp = json['avgRoadTemp'];
    fuelNTFOnEnd = json['fuelNTFOnEnd'];
    fuelEstForNextMiliseconds = json['fuelEstForNextMiliseconds'];
    fuelEFNLapsOnEnd = json['fuelEFNLapsOnEnd'];
    fuelAVGPerLap = json['fuelAVGPerLap'];
    clockAtStart = json['clockAtStart'];
    avgRainIntensity = json['avgRainIntensity'];
    avgTrackGripStatus = json['avgTrackGripStatus'];
    trackStatus = json['trackStatus'];
    driverName = json['driverName'];
    saved = json['saved'];
    mfdTyreSet = json['mfdTyreSet'];
    mfdFuelToAdd = json['mfdFuelToAdd'];
    mfdTyrePressureLF = json['mfdTyrePressureLF'];
    mfdTyrePressureRF = json['mfdTyrePressureRF'];
    mfdTyrePressureLR = json['mfdTyrePressureLR'];
    mfdTyrePressureRR = json['mfdTyrePressureRR'];
    rainIntensityIn10min = json['rainIntensityIn10min'];
    rainIntensityIn30min = json['rainIntensityIn30min'];
    currentTyreSet = json['currentTyreSet'];
    strategyTyreSet = json['strategyTyreSet'];
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
    data['internalLapIndex'] = this.internalLapIndex;
    data['fuelAdded'] = this.fuelAdded;
    data['fuelUsed'] = this.fuelUsed;
    data['fuelBeforePit'] = this.fuelBeforePit;
    data['fuelAfterPit'] = this.fuelAfterPit;
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
    data['avgpFL'] = this.avgpFL;
    data['avgpFR'] = this.avgpFR;
    data['avgpRL'] = this.avgpRL;
    data['avgpRR'] = this.avgpRR;
    data['avgtFL'] = this.avgtFL;
    data['avgtFR'] = this.avgtFR;
    data['avgtRL'] = this.avgtRL;
    data['avgtRR'] = this.avgtRR;
    data['avgBPFL'] = this.avgBPFL;
    data['avgBPFR'] = this.avgBPFR;
    data['avgBPRL'] = this.avgBPRL;
    data['avgBPRR'] = this.avgBPRR;
    data['avgBDFL'] = this.avgBDFL;
    data['avgBDFR'] = this.avgBDFR;
    data['avgBDRL'] = this.avgBDRL;
    data['avgBDRR'] = this.avgBDRR;
    data['avgAirTemp'] = this.avgAirTemp;
    data['avgRoadTemp'] = this.avgRoadTemp;
    data['fuelNTFOnEnd'] = this.fuelNTFOnEnd;
    data['fuelEstForNextMiliseconds'] = this.fuelEstForNextMiliseconds;
    data['fuelEFNLapsOnEnd'] = this.fuelEFNLapsOnEnd;
    data['fuelAVGPerLap'] = this.fuelAVGPerLap;
    data['clockAtStart'] = this.clockAtStart;
    data['avgRainIntensity'] = this.avgRainIntensity;
    data['avgTrackGripStatus'] = this.avgTrackGripStatus;
    data['trackStatus'] = this.trackStatus;
    data['saved'] = this.saved;
    data['mfdTyreSet'] = this.mfdTyreSet;
    data['mfdFuelToAdd'] = this.mfdFuelToAdd;
    data['mfdTyrePressureLF'] = this.mfdTyrePressureLF;
    data['mfdTyrePressureRF'] = this.mfdTyrePressureRF;
    data['mfdTyrePressureLR'] = this.mfdTyrePressureLR;
    data['mfdTyrePressureRR'] = this.mfdTyrePressureRR;
    data['rainIntensityIn10min'] = this.rainIntensityIn10min;
    data['rainIntensityIn30min'] = this.rainIntensityIn30min;
    data['currentTyreSet'] = this.currentTyreSet;
    data['strategyTyreSet'] = this.strategyTyreSet;
    return data;
  }
}

class SplitTimes {
  List<int> splits = [];

  SplitTimes.fromJson(Map<String, dynamic> json){
    int i = 0;
    json.forEach((key, value) {
      int v = value;
      if (i == 0)
        splits.add(v);
      else {
          int sum =0;
          splits.forEach((element) { sum += element;});
          splits.add(v - sum);
      }
      i++;
    });
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
