class StatCar {
  double maxFuel = 0.0;
  String carModel = "";
  String track = "";
  String playerName = "";
  String playerSurname = "";
  String playerNick = "";
  int sectorCount = 0;

  StatCar(
      { required this.maxFuel,
        required this.carModel,
        required this.track,
        required this.playerName,
        required this.playerSurname,
        required this.playerNick,
        required this.sectorCount});

  StatCar.fromJson(Map<String, dynamic> json) {
    maxFuel = json['maxFuel'];
    carModel = json['carModel'];
    track = json['track'];
    playerName = json['playerName'];
    playerSurname = json['playerSurname'];
    playerNick = json['playerNick'];
    sectorCount = json['sectorCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxFuel'] = this.maxFuel;
    data['carModel'] = this.carModel;
    data['track'] = this.track;
    data['playerName'] = this.playerName;
    data['playerSurname'] = this.playerSurname;
    data['playerNick'] = this.playerNick;
    data['sectorCount'] = this.sectorCount;
    return data;
  }
}