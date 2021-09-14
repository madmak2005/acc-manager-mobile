import 'StatSession.dart';

class PageFileStatistics {
  /*
  List<double> pFL = new List<double>();
  List<double> pFR = new List<double>();
  List<double> pRL = new List<double>();
  List<double> pRR = new List<double>();
  List<double> tFL = new List<double>();

  List<double> tFR = new List<double>();
  List<double> tRL = new List<double>();
  List<double> tRR = new List<double>();
  List<double> airTemp = new List<double>();
  List<double> roadTemp = new List<double>();

  List<int> rainIntensity = new List<int>();
  List<int> trackGripStatus = new List<int>();

  Map<int, StatSession> sessions = new Map<int, StatSession>();

   */
  StatSession currentSession;
  double fuelBeforePit = 0;
  double fuelAfterPit = 0;
  String pageName = "";
  String currentDateAndTime = "";
  String previous, current;
  int raceStartAt = 0;
  int sessionCounter = 0;
  String lastChange = "";
  bool saved = false;

  PageFileStatistics.name(

      this.currentSession,
      this.fuelBeforePit,
      this.fuelAfterPit,
      this.pageName,
      this.currentDateAndTime,
      this.previous,
      this.current,
      this.raceStartAt,
      this.sessionCounter,
      this.lastChange,
      this.saved);


  PageFileStatistics.fromJson(Map<String, dynamic> json) {
    currentSession = json['currentSession'] != null ? new StatSession.fromJson(json['currentSession']) : null;
    pageName = json['pageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.currentSession != null) {
      data['currentSession'] = this.currentSession.toJson();
    }
    data['pageName'] = this.pageName;
    return data;
  }

}
