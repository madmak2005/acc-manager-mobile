class PageFilePhysics {
  int? packetId = 0;
  double? gas = 0;
  double? brake = 0;
  double? fuel = 0;
  int? gear = 0;
  int? rpms = 0;
  double? steerAngle = 0;
  double speedKmh = 0;
  List<double> velocity = new List<double>.filled(3, 0, growable: false);
  List<double> accG = [0, 0, 0];
  List<double> wheelSlip = [0, 0, 0, 0];
  List<double> wheelsPressure = [0, 0, 0, 0];
  List<double> wheelAngularSpeed = [0, 0, 0, 0];
  List<double> tyreCoreTemperature = [0, 0, 0, 0];
  List<double> suspensionTravel = [0, 0, 0, 0];
  double? tc = 0.0;
  double? heading = 0.0;
  double? pitch = 0.0;
  double? roll = 0.0;
  List<double> carDamage = [0, 0, 0, 0, 0];
  int? pitLimiterOn = 0;
  double? abs = 0.0;
  int? autoShifterOn = 0;
  double? turboBoost = 0.0;
  double? airTemp = 0.0;
  double? roadTemp = 0.0;
  List<double> localAngularVel = [0, 0, 0];
  double? finalFF = 0.0;
  List<double> brakeTemp = new List<double>.filled(4, 0.0, growable: false);
  double? clutch = 0.0;
  int? isAIControlled = 0;
  List<List<double>> tyreContactPoint =
      new List<List<double>>.filled(4, [0.0, 0.0, 0.0], growable: false);
  List<List<double>> tyreContactNormal =
      new List<List<double>>.filled(4, [0.0, 0.0, 0.0], growable: false);
  List<List<double>> tyreContactHeading =
      new List<List<double>>.filled(4, [0.0, 0.0, 0.0], growable: false);
  double brakeBias = 0.0;
  List<double> localVelocity = [0, 0, 0];
  List<double> mz = [0, 0, 0, 0];
  List<double> fx = [0, 0, 0, 0];
  List<double> fy = [0, 0, 0, 0];

  PageFilePhysics(
      {required this.packetId,
      required this.gas,
      required this.brake,
      required this.fuel,
      required this.gear,
      required this.rpms,
      required this.steerAngle,
      required this.speedKmh,
      required this.velocity,
      required this.accG,
      required this.wheelSlip,
      required this.wheelsPressure,
      required this.wheelAngularSpeed,
      required this.tyreCoreTemperature,
      required this.suspensionTravel,
      required this.tc,
      required this.heading,
      required this.pitch,
      required this.roll,
      required this.carDamage,
      required this.pitLimiterOn,
      required this.abs,
      required this.autoShifterOn,
      required this.turboBoost,
      required this.airTemp,
      required this.roadTemp,
      required this.localAngularVel,
      required this.finalFF,
      required this.brakeTemp,
      required this.clutch,
      required this.isAIControlled,
      required this.tyreContactPoint,
      required this.tyreContactNormal,
      required this.tyreContactHeading,
      required this.brakeBias,
      required this.localVelocity,
      required this.mz,
      required this.fx,
      required this.fy});

  PageFilePhysics.fromJson(Map<String, dynamic> json) {
    packetId = json['packetId'];
    gas = json['gas'];
    brake = json['brake'];
    fuel = json['fuel'];
    gear = json['gear'];
    rpms = json['rpms'];
    steerAngle = json['steerAngle'];
    speedKmh = json['speedKmh'] == null ? 0.0 : json['speedKmh'];
    velocity = json['velocity'] != null
        ? json['velocity'].cast<double>()
        : new List<double>.filled(3, 0, growable: false);
    accG = json['accG'] != null ? json['accG'].cast<double>() : [0, 0, 0];
    wheelSlip = json['wheelSlip'] != null
        ? json['wheelSlip'].cast<double>()
        : [0, 0, 0, 0];
    wheelsPressure = json['wheelsPressure'] != null
        ? json['wheelsPressure'].cast<double>()
        : [0, 0, 0, 0];
    wheelAngularSpeed = json['wheelAngularSpeed'] != null
        ? json['wheelAngularSpeed'].cast<double>()
        : [0, 0, 0, 0];
    tyreCoreTemperature = json['tyreCoreTemperature'] != null
        ? json['tyreCoreTemperature'].cast<double>()
        : [0, 0, 0, 0];
    suspensionTravel = json['suspensionTravel'] != null
        ? json['suspensionTravel'].cast<double>()
        : [0, 0, 0, 0];
    tc = json['tc'];
    heading = json['heading'];
    pitch = json['pitch'];
    roll = json['roll'];
    carDamage = json['carDamage'] != null
        ? json['carDamage'].cast<double>()
        : [0, 0, 0, 0, 0];
    pitLimiterOn = json['pitLimiterOn'];
    abs = json['abs'];
    autoShifterOn = json['autoShifterOn'];
    turboBoost = json['turboBoost'];
    airTemp = json['airTemp'];
    roadTemp = json['roadTemp'];
    localAngularVel = json['localAngularVel'] != null
        ? json['localAngularVel'].cast<double>()
        : [0, 0, 0];
    finalFF = json['finalFF'];
    brakeTemp = json['brakeTemp'] != null
        ? json['brakeTemp'].cast<double>()
        : [0, 0, 0, 0];
    clutch = json['clutch'];
    isAIControlled = json['isAIControlled'];
    if (json['tyreContactPoint'] != null) {
      tyreContactPoint =
          new List<List<double>>.filled(4, [0.0, 0.0, 0.0], growable: false);
      var i = 0;
      json['tyreContactPoint'].forEach((v) {
        var coord = new List<double>.from(v);
        tyreContactPoint[i] = coord;
        i++;
      });
    }
    if (json['tyreContactNormal'] != null) {
      tyreContactNormal =
          new List<List<double>>.filled(4, [0.0, 0.0, 0.0], growable: false);
      var i = 0;
      json['tyreContactNormal'].forEach((v) {
        var coord = new List<double>.from(v);
        tyreContactNormal[i] = coord;
        i++;
      });
    }
    if (json['tyreContactHeading'] != null) {
      tyreContactHeading =
          new List<List<double>>.filled(4, [0.0, 0.0, 0.0], growable: false);
      var i = 0;
      json['tyreContactHeading'].forEach((v) {
        var coord = new List<double>.from(v);
        tyreContactHeading[i] = coord;
        i++;
      });
    }
    brakeBias = json['brakeBias'] == null ? 0.0 : json['brakeBias'];
    localVelocity = json['localVelocity'] != null
        ? json['localVelocity'].cast<double>()
        : [0, 0, 0];
    mz = json['mz'] != null ? json['mz'].cast<double>() : [0, 0, 0, 0];
    fx = json['fx'] != null ? json['fx'].cast<double>() : [0, 0, 0, 0];
    fy = json['fy'] != null ? json['fy'].cast<double>() : [0, 0, 0, 0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packetId'] = this.packetId;
    data['gas'] = this.gas;
    data['brake'] = this.brake;
    data['fuel'] = this.fuel;
    data['gear'] = this.gear;
    data['rpms'] = this.rpms;
    data['steerAngle'] = this.steerAngle;
    data['speedKmh'] = this.speedKmh;
    data['velocity'] = this.velocity;
    data['accG'] = this.accG;
    data['wheelSlip'] = this.wheelSlip;
    data['wheelsPressure'] = this.wheelsPressure;
    data['wheelAngularSpeed'] = this.wheelAngularSpeed;
    data['tyreCoreTemperature'] = this.tyreCoreTemperature;
    data['suspensionTravel'] = this.suspensionTravel;
    data['tc'] = this.tc;
    data['heading'] = this.heading;
    data['pitch'] = this.pitch;
    data['roll'] = this.roll;
    data['carDamage'] = this.carDamage;
    data['pitLimiterOn'] = this.pitLimiterOn;
    data['abs'] = this.abs;
    data['autoShifterOn'] = this.autoShifterOn;
    data['turboBoost'] = this.turboBoost;
    data['airTemp'] = this.airTemp;
    data['roadTemp'] = this.roadTemp;
    data['localAngularVel'] = this.localAngularVel;
    data['finalFF'] = this.finalFF;
    data['brakeTemp'] = this.brakeTemp;
    data['clutch'] = this.clutch;
    data['isAIControlled'] = this.isAIControlled;
    if (this.tyreContactPoint != null) {
      data['tyreContactPoint'] = this.tyreContactPoint.map((v) => v).toList();
    }
    if (this.tyreContactNormal != null) {
      data['tyreContactNormal'] = this.tyreContactNormal.map((v) => v).toList();
    }
    if (this.tyreContactHeading != null) {
      data['tyreContactHeading'] =
          this.tyreContactHeading.map((v) => v).toList();
    }
    data['brakeBias'] = this.brakeBias;
    data['localVelocity'] = this.localVelocity;
    data['mz'] = this.mz;
    data['fx'] = this.fx;
    data['fy'] = this.fy;
    return data;
  }
}

class TyreContactPoint {
  TyreContactPoint.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
