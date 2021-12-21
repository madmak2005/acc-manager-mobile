class PageFileStatic {
  String smVersion = "";
  String acVersion = "";
  int numberOfSessions = 0;
  int numCars = 0;
  String carModel = "";
  String track = "";
  String playerName = "";
  String playerSurname = "";
  String playerNick = "";
  int sectorCount = 0;
  double maxTorque = 0.0;
  double maxPower = 0.0;
  int maxRpm = 0;
  double maxFuel = 0.0;
  List<double> suspensionMaxTravel = [0.0,0.0,0.0,0.0];
  List<double> tyreRadius = [0.0,0.0,0.0,0.0];
  int penaltiesEnabled = 0;
  double aidFuelRate = 0.0;
  double aidTireRate = 0.0;
  double aidMechanicalDamage = 0.0;
  int aidAllowTyreBlankets = 0;
  double aidStability = 0.0;
  int aidAutoClutch = 0;
  int aidAutoBlip = 0;
  double kersMaxJ = 0.0;
  int? reversedGridPositions = 0;
  int? pitWindowStart = 0;
  int? pitWindowEnd = 0;
  int? isOnline = 0;

  PageFileStatic({
      required this.smVersion,
      required this.acVersion,
      required this.numberOfSessions,
      required this.numCars,
      required this.carModel,
      required this.track,
      required this.playerName,
      required this.playerSurname,
      required this.playerNick,
      required this.sectorCount,
      required this.maxTorque,
      required this.maxPower,
      required this.maxRpm,
      required this.maxFuel,
      required this.suspensionMaxTravel,
      required this.tyreRadius,
      required this.penaltiesEnabled,
      required this.aidFuelRate,
      required this.aidTireRate,
      required this.aidMechanicalDamage,
      required this.aidAllowTyreBlankets,
      required this.aidStability,
      required this.aidAutoClutch,
      required this.aidAutoBlip,
      required this.kersMaxJ,
      required this.reversedGridPositions,
      required this.pitWindowStart,
      required this.pitWindowEnd,
      required this.isOnline});

  PageFileStatic.fromJson(Map<String, dynamic> json) {
    smVersion = json['smVersion'];
    acVersion = json['acVersion'];
    numberOfSessions = json['numberOfSessions'];
    numCars = json['numCars'];
    carModel = json['carModel'];
    track = json['track'];
    playerName = json['playerName'];
    playerSurname = json['playerSurname'];
    playerNick = json['playerNick'];
    sectorCount = json['sectorCount'];
    maxTorque = json['maxTorque'];
    maxPower = json['maxPower'];
    maxRpm = json['maxRpm'];
    maxFuel = json['maxFuel'];
    suspensionMaxTravel = json['suspensionMaxTravel'].cast<double>();
    tyreRadius = json['tyreRadius'].cast<double>();
    penaltiesEnabled = json['penaltiesEnabled'];
    aidFuelRate = json['aidFuelRate'];
    aidTireRate = json['aidTireRate'];
    aidMechanicalDamage = json['aidMechanicalDamage'];
    aidAllowTyreBlankets = json['aidAllowTyreBlankets'];
    aidStability = json['aidStability'];
    aidAutoClutch = json['aidAutoClutch'];
    aidAutoBlip = json['aidAutoBlip'];
    kersMaxJ = json['kersMaxJ'];
    reversedGridPositions = json['reversedGridPositions'];
    pitWindowStart = json['pitWindowStart'];
    pitWindowEnd = json['pitWindowEnd'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['smVersion'] = this.smVersion;
    data['acVersion'] = this.acVersion;
    data['numberOfSessions'] = this.numberOfSessions;
    data['numCars'] = this.numCars;
    data['carModel'] = this.carModel;
    data['track'] = this.track;
    data['playerName'] = this.playerName;
    data['playerSurname'] = this.playerSurname;
    data['playerNick'] = this.playerNick;
    data['sectorCount'] = this.sectorCount;
    data['maxTorque'] = this.maxTorque;
    data['maxPower'] = this.maxPower;
    data['maxRpm'] = this.maxRpm;
    data['maxFuel'] = this.maxFuel;
    data['suspensionMaxTravel'] = this.suspensionMaxTravel;
    data['tyreRadius'] = this.tyreRadius;
    data['penaltiesEnabled'] = this.penaltiesEnabled;
    data['aidFuelRate'] = this.aidFuelRate;
    data['aidTireRate'] = this.aidTireRate;
    data['aidMechanicalDamage'] = this.aidMechanicalDamage;
    data['aidAllowTyreBlankets'] = this.aidAllowTyreBlankets;
    data['aidStability'] = this.aidStability;
    data['aidAutoClutch'] = this.aidAutoClutch;
    data['aidAutoBlip'] = this.aidAutoBlip;
    data['kersMaxJ'] = this.kersMaxJ;
    data['reversedGridPositions'] = this.reversedGridPositions;
    data['pitWindowStart'] = this.pitWindowStart;
    data['pitWindowEnd'] = this.pitWindowEnd;
    data['isOnline'] = this.isOnline;
    return data;
  }
}