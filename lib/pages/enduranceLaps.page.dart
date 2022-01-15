import 'package:acc_manager/common/StatMobile.dart';
import 'package:acc_manager/services/LocalStreams.dart';
import 'package:acc_manager/services/RESTSessions.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'login.page.dart';

bool? firstTimeStatistics;

class EnduranceLapsPage extends StatelessWidget {
  int internalSessionIndex;
  BuildContext? context;

  EnduranceLapsPage(this.internalSessionIndex) {}

  void handleClick(String value) {
    switch (value) {
      case 'Save xls':
        {
          RESTSessions.saveSessions().then((v) {
            print(v.body);
            showAlert(v.body);
          });
          break;
        }
    }
  }

  void showAlert(String msg) {
    showDialog(
        context: context!,
        builder: (context) => AlertDialog(
              content: Text(msg,
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.normal)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Statistics"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Save xls'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: MyEnduranceDetailsPage(
            internalSessionIndex: this.internalSessionIndex));
  }
}

class MyEnduranceDetailsPage extends StatefulWidget {
  final int internalSessionIndex;

  MyEnduranceDetailsPage({Key? key, required this.internalSessionIndex})
      : super(key: key);

  @override
  _MyEnduranceDetailsPageState createState() => _MyEnduranceDetailsPageState();
}

class _MyEnduranceDetailsPageState extends State<MyEnduranceDetailsPage> {
  _MyEnduranceDetailsPageState();

  Future<List<StatMobile>> getData() async {
    List<StatMobile> laps = [];
    LocalStreams.stat_sessions.forEach((session) {
      if (session.internalSessionIndex == widget.internalSessionIndex)
        laps = session.laps;
    });
    laps.sort((a, b) => a.lapNo.compareTo(b.lapNo));
    return laps;
  }

  Future<void> _getData() async {
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<List<StatMobile>>(
            future: getData(),
            initialData: [],
            builder: (BuildContext context,
                AsyncSnapshot<List<StatMobile>> snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: _getData,
                  child: SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.amber,
                            height: 48.0,
                            alignment: Alignment.center,
                            child: Row(children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text("Lap",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text("Time in game",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text("Pressure",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Fuel / lap",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Fuel / minute",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Minutes till end",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Fuel for laps",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("Fuel for minutes",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text("",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return DataPopUp(snapshot
                                  .data![snapshot.data!.length - index - 1]);
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        ],
                      )),
                );
              } else {
                return Container(
                    color: Colors.black54,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                        Text(
                          Consts.title,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'You need to finish at least one full lap.',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            Consts.description,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                      ],
                    )));
              }
            }));
  }
}

class StatRow extends StatelessWidget {
  StatMobile lap = new StatMobile.empty();

  StatRow(StatMobile lap) {
    this.lap = lap;
  }

  String _printDurationMinutesSeconds(int miliseconds) {
    //lap.fuelEstForNextMiliseconds.toInt()
    Duration duration = Duration(milliseconds: miliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes =
        twoDigits((duration.inHours * 60) + duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String _printDurationHoursMinutes(int milliseconds) {
    Duration duration = new Duration(milliseconds: milliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String threeDigits(int n) => n.toString().padLeft(3, "0");

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    //String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    //String threeDigitMilliSeconds = threeDigits(duration.inSeconds.remainder(100));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(lap.lapNo.toString(),
                style: TextStyle(
                    color: lap.isValidLap ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)),
          ),
          Expanded(
            flex: 1,
            child: Text(
                _printDurationHoursMinutes(lap.clockAtStart.toInt() * 1000),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal)),
          ),
          Expanded(
            flex: 2,
            child: Row(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(lap.avgpFL.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(lap.avgpRL.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(lap.avgpFR.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(lap.avgpRR.toStringAsFixed(2),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
            ]),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(lap.fuelAVGPerLap.toStringAsFixed(3),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(lap.fuelAVGPerMinute.toStringAsFixed(2),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                  _printDurationHoursMinutes(lap.sessionTimeLeft.toInt()),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(lap.fuelEFNLapsOnEnd.toStringAsFixed(2),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                  _printDurationMinutesSeconds(
                      lap.fuelEstForNextMiliseconds.toInt()),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
            ),
          )
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  Icon? icon;
  String? action;

  ButtonWidget(Icon icon, String action) {
    this.icon = icon;
    this.action = action;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
          onTap: () => RESTVirtualKeyboard.sendkey(action!), child: icon),
    );
  }
}

class DataPopUp extends StatelessWidget {
  const DataPopUp(this.popup);

  final StatMobile popup;

  String _printDurationHoursMinutesSeconds(int miliseconds) {
    //lap.fuelEstForNextMiliseconds.toInt()
    Duration duration = Duration(milliseconds: miliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String twoDigitMilliSeconds = twoDigits(duration.inSeconds.remainder(100));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _printDurationHoursMinutesSecondsMilliseconds(int miliseconds) {
    //lap.fuelEstForNextMiliseconds.toInt()
    Duration duration = Duration(milliseconds: miliseconds);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String threeDigits(int n) => n.toString().padLeft(3, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String threeDigitMilliSeconds =
        threeDigits(duration.inMilliseconds - duration.inSeconds * 1000);
    //print("${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds.$threeDigitMilliSeconds");
    //print(duration);
    //print(duration.inMilliseconds);
    //print(duration.inSeconds);
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds.$threeDigitMilliSeconds";
  }

  Widget _splitTimes(SplitTimes splitTimes) {
    List<int> splits = splitTimes.splits;

    return Container(
      child: ListView.builder(
          itemCount: splits.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(
              " | " +
                  _printDurationHoursMinutesSecondsMilliseconds(splits[index]),
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
    );
  }

  Widget _buildTiles(StatMobile root) {
    return ExpansionTile(
        key: PageStorageKey<StatMobile>(root),
        controlAffinity: ListTileControlAffinity.platform,
        tilePadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        collapsedIconColor: Colors.white,
        title: StatRow(root),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(1, 1, 1, 0),
            height: 170,
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Card(
              color: Colors.black,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 0, top: 2),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Driver name: ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            root.driverName,
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Track status: ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            root.trackStatus,
                                            style: TextStyle(
                                              color:
                                                  root.trackStatus == 'OPTIMUM'
                                                      ? Colors.green
                                                      : Colors.yellow,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Rain: ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            root.avgRainIntensity
                                                .toStringAsFixed(1),
                                            style: TextStyle(
                                              color: root.avgRainIntensity > 0
                                                  ? Colors.yellow
                                                  : Colors.green,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Row(
                                        children: [
                                          BoxedData.name(
                                              _printDurationHoursMinutesSeconds(
                                                  root.clockAtStart.toInt() *
                                                      1000),
                                              Icon(
                                                MaterialCommunityIcons
                                                    .clock_start,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              root.avgRoadTemp
                                                      .toStringAsFixed(1) +
                                                  " °C",
                                              Icon(
                                                MaterialCommunityIcons
                                                    .road_variant,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              root.avgAirTemp
                                                      .toStringAsFixed(1) +
                                                  " °C",
                                              Icon(
                                                MaterialCommunityIcons
                                                    .thermometer_lines,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              root.fuelLeftOnEnd
                                                      .toStringAsFixed(2) +
                                                  " l",
                                              Icon(
                                                MaterialCommunityIcons
                                                    .gas_station,
                                                color: root.fuelAdded > 0
                                                    ? Colors.green.shade400
                                                    : Colors.red.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              (root.fuelLeftOnStart -
                                                          root.fuelLeftOnEnd +
                                                          root.fuelAdded)
                                                      .toStringAsFixed(2) +
                                                  " l",
                                              Icon(
                                                MaterialCommunityIcons.fuel,
                                                color: Colors.red.shade400,
                                                size: 19,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Row(
                                        children: [
                                          BoxedData.name(
                                              _printDurationHoursMinutesSecondsMilliseconds(
                                                  root.lapTime),
                                              Icon(
                                                MaterialCommunityIcons.av_timer,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          Row(
                                              children: root.splitTimes!.splits
                                                  .map<Widget>(
                                                    (e) => e > 0
                                                        ? BoxedData.name(
                                                            _printDurationHoursMinutesSecondsMilliseconds(
                                                                    e) +
                                                                " ",
                                                            Icon(
                                                              MaterialCommunityIcons
                                                                  .timer,
                                                              color: Colors.blue
                                                                  .shade400,
                                                              size: 7,
                                                            ))
                                                        : new SizedBox.shrink(),
                                                  )
                                                  .toList()),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Row(
                                        children: [
                                          BoxedData.name(
                                              'MFD [LF]: ' +
                                                  root.mfdTyrePressureLF
                                                      .toStringAsFixed(1),
                                              Icon(
                                                MaterialCommunityIcons
                                                    .arrow_top_left,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              'MFD [RF]: ' +
                                                  root.mfdTyrePressureRF
                                                      .toStringAsFixed(1),
                                              Icon(
                                                MaterialCommunityIcons
                                                    .arrow_top_right,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              'MFD [l]: ' +
                                                  root.mfdFuelToAdd.toString(),
                                              Icon(
                                                MaterialCommunityIcons.fuel,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Row(
                                        children: [
                                          BoxedData.name(
                                              'MFD [LR]: ' +
                                                  root.mfdTyrePressureLR
                                                      .toStringAsFixed(1),
                                              Icon(
                                                MaterialCommunityIcons
                                                    .arrow_bottom_left,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              'MFD [RR]: ' +
                                                  root.mfdTyrePressureRR
                                                      .toStringAsFixed(1),
                                              Icon(
                                                MaterialCommunityIcons
                                                    .arrow_bottom_right,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                          BoxedData.name(
                                              'MFD [set]: ' +
                                                  root.mfdTyreSet.toString(),
                                              Icon(
                                                MaterialCommunityIcons.reload,
                                                color: Colors.blue.shade400,
                                                size: 19,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup);
  }
}

class BoxedData extends StatelessWidget {
  String text;
  Icon icon;

  BoxedData.name(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.indigo,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              this.icon,
              Text(
                this.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }
}
