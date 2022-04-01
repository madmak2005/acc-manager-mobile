import 'dart:convert';
import 'dart:developer';

import 'package:acc_manager/common/StatMobile.dart';
import 'package:acc_manager/common/StatSession.dart';
import 'package:acc_manager/pages/previousSession.page.dart';
import 'package:acc_manager/services/LocalStreams.dart';
import 'package:acc_manager/services/RESTSessions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'endurance.page.dart';
import 'enduranceLaps.page.dart';

class EnduranceSessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Endurance sessions'),
      ),
      // Display our list widget
      body: Center(child: ShowFutureThings()),
    );
  }
}

class ShowFutureThings extends StatefulWidget {
  @override
  _ShowFutureThingsState createState() => _ShowFutureThingsState();
}

Future<List<StatSession>> getHttpData() async {
  return RESTSessions.getPreviousSessions();
}

class _ShowFutureThingsState extends State<ShowFutureThings> {
  Future<void> _getData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getData,
      child: SessionsList(),
    );
  }
}

class SessionsList extends StatelessWidget {
  const SessionsList({
    Key? key,
  }) : super(key: key);

  bool _anyValidLap(List<StatMobile> laps) {
    bool valid = false;
    laps.forEach((lap) {
      if (lap.lapNo != 0) valid = true;
    });
    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: LocalStreams.stat_sessions.length,
        itemBuilder: (context, index) {
          return _anyValidLap(LocalStreams.stat_sessions[index].laps)
              ? EnduRow(index, context)
              : SizedBox.shrink();
        },
      ),
    );
  }

  Column EnduRow(int index, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: DriverList(index)),
            Expanded(
              flex: 2,
              child: new ListTile(
                title: Row(
                  children: [
                    new Text(
                      LocalStreams.stat_sessions[index].car.carModel
                          .toUpperCase()
                          .replaceAll("_", " "),
                      style: GoogleFonts.comfortaa(
                          textStyle: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.w900)),
                    ),
                    new Text(
                      "|" +
                          LocalStreams.stat_sessions[index].car.track
                              .toUpperCase()
                              .replaceAll("_", " "),
                      style: GoogleFonts.comfortaa(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 91, 255, 140),
                              fontSize: 11,
                              fontWeight: FontWeight.w900)),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            new Text(
                              "Fuel per lap: ",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                              LocalStreams.stat_sessions[index].fuelAVG5Laps > 0
                                  ? LocalStreams
                                      .stat_sessions[index].fuelAVG5Laps
                                      .toStringAsFixed(2)
                                  : LocalStreams.stat_sessions[index]
                                              .fuelAVG3Laps >
                                          0
                                      ? LocalStreams
                                          .stat_sessions[index].fuelAVG3Laps
                                          .toStringAsFixed(2)
                                      : "?",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            new Text(
                              "Fuel per minute: ",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                              LocalStreams.stat_sessions[index].avgLapTime5 != 0
                                  ? ((LocalStreams.stat_sessions[index]
                                              .fuelAVG5Laps) /
                                          (LocalStreams.stat_sessions[index]
                                                  .avgLapTime5 /
                                              1000 /
                                              60))
                                      .toStringAsFixed(3)
                                  : LocalStreams.stat_sessions[index]
                                              .avgLapTime3 !=
                                          0
                                      ? ((LocalStreams.stat_sessions[index]
                                                  .fuelAVG3Laps) /
                                              (LocalStreams.stat_sessions[index]
                                                      .avgLapTime3 /
                                                  1000 /
                                                  60))
                                          .toStringAsFixed(3)
                                      : "?",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            new Text(
                              "FuelXLap [ACC]: ",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                              LocalStreams.stat_sessions[index].fuelXLap
                                  .toStringAsFixed(2),
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          new Text(" [laps: ",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900))),
                          new Text(
                              LocalStreams.stat_sessions[index].laps.length
                                  .toString(),
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900))),
                          new Text("]",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900))),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _openEnduranceDetails(index)));
                },
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.blue,
          height: 10,
        ),
      ],
    );
  }

  _openEnduranceDetails(int index) {
    log('index:' + index.toString());
    return EnduranceLapsPage(
        LocalStreams.stat_sessions[index].internalSessionIndex);
  }
}

class DriverList extends StatelessWidget {
  final index;
  const DriverList(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
          child: new Text(
            'Drivers in session:',
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900)),
          ),
        ),
        Divider(
          height: 3,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: LocalStreams.stat_sessions[index].driverSet.length,
            itemBuilder: (context, index2) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      LocalStreams.stat_sessions[index].driverSet
                          .elementAt(index2)
                          .toUpperCase(),
                      style: GoogleFonts.comfortaa(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 208, 0),
                              fontSize: 8,
                              fontWeight: FontWeight.w900)),
                    ),
                  ]);
            }),
      ],
    );
  }
}
