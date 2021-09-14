class StatCar {
  double maxFuel;
  String carModel;
  String track;
  String playerName;
  int sectorCount;

  StatCar(
      {this.maxFuel,
        this.carModel,
        this.track,
        this.playerName,
        this.sectorCount});

  StatCar.fromJson(Map<String, dynamic> json) {
    maxFuel = json['maxFuel'];
    carModel = json['carModel'];
    track = json['track'];
    playerName = json['playerName'];
    sectorCount = json['sectorCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxFuel'] = this.maxFuel;
    data['carModel'] = this.carModel;
    data['track'] = this.track;
    data['playerName'] = this.playerName;
    data['sectorCount'] = this.sectorCount;
    return data;
  }
}