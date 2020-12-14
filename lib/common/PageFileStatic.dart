class PageFileStatic {
  String smVersion;
  String acVersion;
  int numberOfSessions;
  int numCars;
  String carModel;
  String track;
  String playerName;
  String playerSurname;
  String playerNick;
  int sectorCount;
  double maxTorque;
  double maxPower;
  int maxRpm;
  double maxFuel;
  List<double> suspensionMaxTravel;
  List<double> tyreRadius;
  int penaltiesEnabled;
  double aidFuelRate;
  double aidTireRate;
  double aidMechanicalDamage;
  int aidAllowTyreBlankets;
  double aidStability;
  int aidAutoClutch;
  int aidAutoBlip;
  double kersMaxJ;
  int reversedGridPositions;
  int pitWindowStart;
  int pitWindowEnd;
  int isOnline;

  PageFileStatic(
      {this.smVersion,
        this.acVersion,
        this.numberOfSessions,
        this.numCars,
        this.carModel,
        this.track,
        this.playerName,
        this.playerSurname,
        this.playerNick,
        this.sectorCount,
        this.maxTorque,
        this.maxPower,
        this.maxRpm,
        this.maxFuel,
        this.suspensionMaxTravel,
        this.tyreRadius,
        this.penaltiesEnabled,
        this.aidFuelRate,
        this.aidTireRate,
        this.aidMechanicalDamage,
        this.aidAllowTyreBlankets,
        this.aidStability,
        this.aidAutoClutch,
        this.aidAutoBlip,
        this.kersMaxJ,
        this.reversedGridPositions,
        this.pitWindowStart,
        this.pitWindowEnd,
        this.isOnline});

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
    suspensionMaxTravel = json['suspensionMaxTravel'] != null ? json['suspensionMaxTravel'].cast<double>() : new List<double>();
    tyreRadius = json['tyreRadius'] != null ? json['tyreRadius'].cast<double>() : new List<double>();
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