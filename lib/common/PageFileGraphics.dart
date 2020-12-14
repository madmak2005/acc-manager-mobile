class PageFileGraphics {
  int packetId = 0;
  int status = 0;
  int session = 0;
  String currentTime = "";
  String lastTime = "";
  String bestTime = "";
  String split = "";
  int completedLaps = 0;
  int position = 0;
  int iCurrentTime = 0;
  int iLastTime = 0;
  int iBestTime = 0;
  double sessionTimeLeft = 0;
  double distanceTraveled = 0;
  int isInPit = 0;
  int currentSectorIndex = 0;
  int lastSectorTime = 0;
  int numberOfLaps = 0;
  String tyreCompound;
  double replayTimeMultiplier = 0;
  double normalizedCarPosition = 0;
  int activeCars = 0;
  List<List> carCoordinates;
  List<int> carID = new List<int>(60);
  int playerCarID = 0;
  double penaltyTime = 0;
  int flag = 0;
  int penalty = 0;
  int idealLineOn = 0;
  int isInPitLane = 0;
  double surfaceGrip = 0;
  int mandatoryPitDone = 0;
  double windSpeed = 0;
  double windDirection = 0;
  int isSetupMenuVisible = 0;
  int mainDisplayIndex = 0;
  int secondaryDisplayIndex = 0;
  int tc = 0;
  int tccut = 0;
  int engineMap = 0;
  int abs = 0;
  int fuelXLap = 0;
  int rainLights = 0;
  int flashingLights = 0;
  int lightsStage = 0;
  double exhaustTemperature = 0;
  int wiperLV = 0;
  int driverStintTotalTimeLeft = 0;
  int driverStintTimeLeft = 0;
  int rainTyres = 0;

  PageFileGraphics(
      {this.packetId,
      this.status,
      this.session,
      this.currentTime,
      this.lastTime,
      this.bestTime,
      this.split,
      this.completedLaps,
      this.position,
      this.iCurrentTime,
      this.iLastTime,
      this.iBestTime,
      this.sessionTimeLeft,
      this.distanceTraveled,
      this.isInPit,
      this.currentSectorIndex,
      this.lastSectorTime,
      this.numberOfLaps,
      this.tyreCompound,
      this.replayTimeMultiplier,
      this.normalizedCarPosition,
      this.activeCars,
      this.carCoordinates,
      this.carID,
      this.playerCarID,
      this.penaltyTime,
      this.flag,
      this.penalty,
      this.idealLineOn,
      this.isInPitLane,
      this.surfaceGrip,
      this.mandatoryPitDone,
      this.windSpeed,
      this.windDirection,
      this.isSetupMenuVisible,
      this.mainDisplayIndex,
      this.secondaryDisplayIndex,
      this.tc,
      this.tccut,
      this.engineMap,
      this.abs,
      this.fuelXLap,
      this.rainLights,
      this.flashingLights,
      this.lightsStage,
      this.exhaustTemperature,
      this.wiperLV,
      this.driverStintTotalTimeLeft,
      this.driverStintTimeLeft,
      this.rainTyres});

  PageFileGraphics.fromJson(Map<String, dynamic> json) {
    packetId = json['packetId'];
    status = json['status'];
    session = json['session'];
    currentTime = json['currentTime'];
    lastTime = json['lastTime'];
    bestTime = json['bestTime'];
    split = json['split'];
    completedLaps = json['completedLaps'];
    position = json['position'];
    iCurrentTime = json['iCurrentTime'];
    iLastTime = json['iLastTime'];
    iBestTime = json['iBestTime'];
    sessionTimeLeft = json['sessionTimeLeft'];
    distanceTraveled = json['distanceTraveled'];
    isInPit = json['isInPit'];
    currentSectorIndex = json['currentSectorIndex'];
    lastSectorTime = json['lastSectorTime'];
    numberOfLaps = json['numberOfLaps'];
    tyreCompound = json['tyreCompound'];
    replayTimeMultiplier = json['replayTimeMultiplier'];
    normalizedCarPosition = json['normalizedCarPosition'];
    activeCars = json['activeCars'];

    if (json['carCoordinates'] != null) {
      carCoordinates = new List<List>();
      json['carCoordinates'].forEach((v) {
        carCoordinates.add((v));
      });
    }
    carID = json['carID'] != null ? json['carID'].cast<int>() : new List<int>(60);
    playerCarID = json['playerCarID'];
    penaltyTime = json['penaltyTime'];
    flag = json['flag'];
    penalty = json['penalty'];
    idealLineOn = json['idealLineOn'];
    isInPitLane = json['isInPitLane'];
    surfaceGrip = json['surfaceGrip'];
    mandatoryPitDone = json['mandatoryPitDone'];
    windSpeed = json['windSpeed'];
    windDirection = json['windDirection'];
    isSetupMenuVisible = json['isSetupMenuVisible'];
    mainDisplayIndex = json['mainDisplayIndex'];
    secondaryDisplayIndex = json['secondaryDisplayIndex'];
    tc = json['TC'];
    tccut = json['TCCut'];
    engineMap = json['EngineMap'];
    abs = json['ABS'];
    fuelXLap = json['fuelXLap'];
    rainLights = json['rainLights'];
    flashingLights = json['flashingLights'];
    lightsStage = json['lightsStage'];
    exhaustTemperature = json['exhaustTemperature'];
    wiperLV = json['wiperLV'];
    driverStintTotalTimeLeft = json['DriverStintTotalTimeLeft'];
    driverStintTimeLeft = json['DriverStintTimeLeft'];
    rainTyres = json['rainTyres'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packetId'] = this.packetId;
    data['status'] = this.status;
    data['session'] = this.session;
    data['currentTime'] = this.currentTime;
    data['lastTime'] = this.lastTime;
    data['bestTime'] = this.bestTime;
    data['split'] = this.split;
    data['completedLaps'] = this.completedLaps;
    data['position'] = this.position;
    data['iCurrentTime'] = this.iCurrentTime;
    data['iLastTime'] = this.iLastTime;
    data['iBestTime'] = this.iBestTime;
    data['sessionTimeLeft'] = this.sessionTimeLeft;
    data['distanceTraveled'] = this.distanceTraveled;
    data['isInPit'] = this.isInPit;
    data['currentSectorIndex'] = this.currentSectorIndex;
    data['lastSectorTime'] = this.lastSectorTime;
    data['numberOfLaps'] = this.numberOfLaps;
    data['tyreCompound'] = this.tyreCompound;
    data['replayTimeMultiplier'] = this.replayTimeMultiplier;
    data['normalizedCarPosition'] = this.normalizedCarPosition;
    data['activeCars'] = this.activeCars;
    if (this.carCoordinates != null) {
      data['carCoordinates'] = this.carCoordinates.map((v) => v).toList();
    }
    data['carID'] = this.carID;
    data['playerCarID'] = this.playerCarID;
    data['penaltyTime'] = this.penaltyTime;
    data['flag'] = this.flag;
    data['penalty'] = this.penalty;
    data['idealLineOn'] = this.idealLineOn;
    data['isInPitLane'] = this.isInPitLane;
    data['surfaceGrip'] = this.surfaceGrip;
    data['mandatoryPitDone'] = this.mandatoryPitDone;
    data['windSpeed'] = this.windSpeed;
    data['windDirection'] = this.windDirection;
    data['isSetupMenuVisible'] = this.isSetupMenuVisible;
    data['mainDisplayIndex'] = this.mainDisplayIndex;
    data['secondaryDisplayIndex'] = this.secondaryDisplayIndex;
    data['TC'] = this.tc;
    data['TCCut'] = this.tccut;
    data['EngineMap'] = this.engineMap;
    data['ABS'] = this.abs;
    data['fuelXLap'] = this.fuelXLap;
    data['rainLights'] = this.rainLights;
    data['flashingLights'] = this.flashingLights;
    data['lightsStage'] = this.lightsStage;
    data['exhaustTemperature'] = this.exhaustTemperature;
    data['wiperLV'] = this.wiperLV;
    data['DriverStintTotalTimeLeft'] = this.driverStintTotalTimeLeft;
    data['DriverStintTimeLeft'] = this.driverStintTimeLeft;
    data['rainTyres'] = this.rainTyres;
    return data;
  }
}

class CarCoordinates {
  CarCoordinates.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
