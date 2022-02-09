class StatMobile {
  String teamCode = "";
  String pin = "";
  int lapNo = 0;
  bool fromPit = false;
  bool toPit = false;
  int lapTime = 0;
  double distanceTraveled = 0.0;
  SplitTimes? splitTimes;
  int internalLapIndex = 0;
  double fuelAdded = 0.0;
  double fuelUsed = 0.0;
  double fuelBeforePit = 0.0;
  double fuelAfterPit = 0.0;
  double fuelLeftOnStart = 0.0;
  double fuelLeftOnEnd = 0.0;
  double fuelAVGPerMinute = 0.0;
  double fuelXlap = 0.0;
  Maps? maps;
  int rainTyres = 0;
  bool isValidLap = true;
  bool first = false;
  bool last = false;
  double sessionTimeLeft = 0.0;
  String session_TYPE = "";
  int sessionIndex = 0;
  int internalSessionIndex = 0;
  double avgpFL = 0.0;
  double avgpFR = 0.0;
  double avgpRL = 0.0;
  double avgpRR = 0.0;
  double avgtFL = 0.0;
  double avgtFR = 0.0;
  double avgtRL = 0.0;
  double avgtRR = 0.0;
  double avgBPFL = 0.0;
  double avgBPFR = 0.0;
  double avgBPRL = 0.0;
  double avgBPRR = 0.0;
  double avgBDFL = 0.0;
  double avgBDFR = 0.0;
  double avgBDRL = 0.0;
  double avgBDRR = 0.0;
  double avgAirTemp = 0.0;
  double avgRoadTemp = 0.0;
  double fuelNTFOnEnd = 0.0;
  double fuelEstForNextMiliseconds = 0.0;
  double fuelEFNLapsOnEnd = 0.0;
  double fuelAVGPerLap = 0.0;
  double clockAtStart = 0.0;
  double avgRainIntensity = 0.0;
  double avgTrackGripStatus = 0.0;
  String trackStatus = "";
  String driverName = "";
  bool saved = false;
  int mfdTyreSet = 0;
  double mfdFuelToAdd = 0.0;
  double mfdTyrePressureLF = 0.0;
  double mfdTyrePressureRF = 0.0;
  double mfdTyrePressureLR = 0.0;
  double mfdTyrePressureRR = 0.0;
  int rainIntensityIn10min = 0;
  int rainIntensityIn30min = 0;
  int currentTyreSet = 0;
  int strategyTyreSet = 0;
  String carModel = "";
  String track = "";
  StatMobile.empty();
  int position = 0;
  int driverStintTotalTimeLeft = 0;
  int driverStintTimeLeft = 0;

  StatMobile(
      {required this.teamCode,
      required this.pin,
      required this.lapNo,
      required this.fromPit,
      required this.toPit,
      required this.lapTime,
      required this.distanceTraveled,
      required this.splitTimes,
      required this.internalLapIndex,
      required this.fuelAdded,
      required this.fuelUsed,
      required this.fuelBeforePit,
      required this.fuelAfterPit,
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
      required this.session_TYPE,
      required this.sessionIndex,
      required this.internalSessionIndex,
      required this.avgpFL,
      required this.avgpFR,
      required this.avgpRL,
      required this.avgpRR,
      required this.avgtFL,
      required this.avgtFR,
      required this.avgtRL,
      required this.avgtRR,
      required this.avgBPFL,
      required this.avgBPFR,
      required this.avgBPRL,
      required this.avgBPRR,
      required this.avgBDFL,
      required this.avgBDFR,
      required this.avgBDRL,
      required this.avgBDRR,
      required this.avgAirTemp,
      required this.avgRoadTemp,
      required this.fuelNTFOnEnd,
      required this.fuelEstForNextMiliseconds,
      required this.fuelEFNLapsOnEnd,
      required this.fuelAVGPerLap,
      required this.clockAtStart,
      required this.avgRainIntensity,
      required this.avgTrackGripStatus,
      required this.trackStatus,
      required this.driverName,
      required this.saved,
      required this.mfdTyreSet,
      required this.mfdFuelToAdd,
      required this.mfdTyrePressureLF,
      required this.mfdTyrePressureRF,
      required this.mfdTyrePressureLR,
      required this.mfdTyrePressureRR,
      required this.rainIntensityIn10min,
      required this.rainIntensityIn30min,
      required this.currentTyreSet,
      required this.strategyTyreSet,
      required this.carModel,
      required this.track,
      required this.position,
      required this.driverStintTotalTimeLeft,
      required this.driverStintTimeLeft});

  StatMobile.fromJson(Map<String, dynamic> json) {
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
    internalLapIndex = json['internalLapIndex'];
    fuelAdded = json['fuelAdded'] == null ? 0 : json['fuelAdded'];
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
    session_TYPE = json['session_TYPE'];
    sessionIndex = json['sessionIndex'];
    internalSessionIndex = json['internalSessionIndex'];
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
    fuelNTFOnEnd = json['fuelNTFOnEnd'] == null ? 0 : json['fuelNTFOnEnd'];
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
    carModel = json['carModel'] == null ? "not kwnown" : json['carModel'];
    track = json['track'] == null ? "not kwnown" : json['track'];
    position = json['position'] == null ? 0 : json['position'];
    driverStintTotalTimeLeft = json['driverStintTotalTimeLeft'] == null
        ? 0
        : json['driverStintTotalTimeLeft'];
    driverStintTimeLeft =
        json['driverStintTimeLeft'] == null ? 0 : json['driverStintTimeLeft'];
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
      //data['splitTimes'] = this.splitTimes!.splits.map((v) => v).toList();
      data['splitTimes'] = this.splitTimes!.toJson();
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
      data['maps'] = this.maps!.toJson();
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
    data['driverName'] = this.driverName;
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
    data['carModel'] = this.carModel;
    data['track'] = this.track;
    data['position'] = this.position;
    data['driverStintTotalTimeLeft'] = this.driverStintTotalTimeLeft;
    data['driverStintTimeLeft'] = this.driverStintTimeLeft;
    return data;
  }
}

class SplitTimes {
  List<int> splits = [];

  SplitTimes.fromJson(Map<String, dynamic> json) {
    int i = 0;
    json.forEach((key, value) {
      int v = value;
      if (i == 0)
        splits.add(v);
      else {
        int sum = 0;
        splits.forEach((element) {
          sum += element;
        });
        splits.add(v - sum);
      }
      i++;
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    int i = 1;
    splits.forEach((element) {
      data.putIfAbsent(i.toString(), () => element);
      i++;
    });

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
