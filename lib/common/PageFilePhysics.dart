class PageFilePhysics {
  int packetId;
  double gas;
  double brake;
  double fuel;
  int gear;
  int rpms;
  double steerAngle;
  double speedKmh;
  List<double> velocity = new List<double>(3);
  List<double> accG;
  List<double> wheelSlip;
  List<double> wheelsPressure;
  List<double> wheelAngularSpeed;
  List<double> tyreCoreTemperature;
  List<double> suspensionTravel;
  double tc;
  double heading;
  double pitch;
  double roll;
  List<double> carDamage;
  int pitLimiterOn;
  double abs;
  int autoShifterOn;
  double turboBoost;
  double airTemp;
  double roadTemp;
  List<double> localAngularVel;
  double finalFF;
  List<double> brakeTemp;
  double clutch;
  int isAIControlled;
  List<List> tyreContactPoint;
  List<List> tyreContactNormal;
  List<List> tyreContactHeading;
  double brakeBias;
  List<double> localVelocity;
  List<double> mz;
  List<double> fx;
  List<double> fy;

  PageFilePhysics(
      {this.packetId,
      this.gas,
      this.brake,
      this.fuel,
      this.gear,
      this.rpms,
      this.steerAngle,
      this.speedKmh,
      this.velocity,
      this.accG,
      this.wheelSlip,
      this.wheelsPressure,
      this.wheelAngularSpeed,
      this.tyreCoreTemperature,
      this.suspensionTravel,
      this.tc,
      this.heading,
      this.pitch,
      this.roll,
      this.carDamage,
      this.pitLimiterOn,
      this.abs,
      this.autoShifterOn,
      this.turboBoost,
      this.airTemp,
      this.roadTemp,
      this.localAngularVel,
      this.finalFF,
      this.brakeTemp,
      this.clutch,
      this.isAIControlled,
      this.tyreContactPoint,
      this.tyreContactNormal,
      this.tyreContactHeading,
      this.brakeBias,
      this.localVelocity,
      this.mz,
      this.fx,
      this.fy});

  PageFilePhysics.fromJson(Map<String, dynamic> json) {
    packetId = json['packetId'];
    gas = json['gas'];
    brake = json['brake'];
    fuel = json['fuel'];
    gear = json['gear'];
    rpms = json['rpms'];
    steerAngle = json['steerAngle'];
    speedKmh = json['speedKmh'];
    velocity = json['velocity'] != null ? json['velocity'].cast<double>() : new List<double>();
    accG =  json['accG'] != null ? json['accG'].cast<double>() : new List<double>();
    wheelSlip = json['wheelSlip'] != null ? json['wheelSlip'].cast<double>() : new List<double>();
    wheelsPressure = json['wheelsPressure'] != null ? json['wheelsPressure'].cast<double>() : new List<double>();
    wheelAngularSpeed = json['wheelAngularSpeed'] != null ? json['wheelAngularSpeed'].cast<double>() : new List<double>();
    tyreCoreTemperature = json['tyreCoreTemperature'] != null ? json['tyreCoreTemperature'].cast<double>() : new List<double>();
    suspensionTravel = json['suspensionTravel'] != null ? json['suspensionTravel'].cast<double>() : new List<double>();
    tc = json['tc'];
    heading = json['heading'];
    pitch = json['pitch'];
    roll = json['roll'];
    carDamage = json['carDamage'] != null ? json['carDamage'].cast<double>() : new List<double>();
    pitLimiterOn = json['pitLimiterOn'];
    abs = json['abs'];
    autoShifterOn = json['autoShifterOn'];
    turboBoost = json['turboBoost'];
    airTemp = json['airTemp'];
    roadTemp = json['roadTemp'];
    localAngularVel = json['localAngularVel'] != null ? json['localAngularVel'].cast<double>() : new List<double>();
    finalFF = json['finalFF'];
    brakeTemp = json['brakeTemp'] != null ? json['brakeTemp'].cast<double>() : new List<double>();
    clutch = json['clutch'];
    isAIControlled = json['isAIControlled'];
    if (json['tyreContactPoint'] != null) {
      tyreContactPoint = new List<List>();
      json['tyreContactPoint'].forEach((v) {
        tyreContactPoint.add((v));
      });
    }
    if (json['tyreContactNormal'] != null) {
      tyreContactNormal = new List<List>();
      json['tyreContactNormal'].forEach((v) {
        tyreContactNormal.add((v));
      });
    }
    if (json['tyreContactHeading'] != null) {
      tyreContactHeading = new List<List>();
      json['tyreContactHeading'].forEach((v) {
        tyreContactHeading.add((v));
      });
    }
    brakeBias = json['brakeBias'];
    localVelocity =json['localVelocity'] != null ? json['localVelocity'].cast<double>() : new List<double>();
    mz = json['mz'] != null ? json['mz'].cast<double>() : new List<double>();
    fx = json['fx'] != null ? json['fx'].cast<double>() : new List<double>();
    fy = json['fy'] != null ? json['fy'].cast<double>() : new List<double>();
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
  TyreContactPoint.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
