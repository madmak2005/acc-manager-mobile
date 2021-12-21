import 'dart:convert';

import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/common/PageFileGraphics.dart';
import 'package:acc_manager/common/PageFilePhysics.dart';
import 'package:acc_manager/common/StatMobile.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/pages/widgets/Buttons.dart';
import 'package:acc_manager/pages/widgets/plusMinus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'login.page.dart';

class ControlPage extends StatelessWidget {
  final Map<String, KeySettings> keySetting;

  ControlPage(this.keySetting);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: MyControlPage(
          channelGraphics: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/graphics'))
              : IOWebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/graphics')),
          channelPhysics: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/physics'))
              : IOWebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/physics')),
          channelMobStatistics: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/mobileStats'))
              : IOWebSocketChannel.connect(Uri.parse(
                  'ws://${conf.serverIP}:${conf.serverPort}/acc/mobileStats')),
          keySetting: this.keySetting,
        ));
  }
}

class MyControlPage extends StatefulWidget {
  final WebSocketChannel channelGraphics, channelPhysics, channelMobStatistics;
  final Map<String, KeySettings> keySetting;
  MyControlPage(
      {Key? key,
      required this.channelGraphics,
      required this.channelPhysics,
      required this.channelMobStatistics,
      required this.keySetting})
      : super(key: key);

  @override
  _MyControlPageState createState() => _MyControlPageState(this.keySetting);
}

class _MyControlPageState extends State<MyControlPage> {
  _MyControlPageState(this.keySetting);

  bool firstTimeGraphics = true;
  bool firstTimePhysics = true;
  bool firstTimeStatic = true;

  var maxSpeed = 0.0;
  var minSpeed = 500.0;
  var lastPos = 0.0;

  String _printDurationHoursMinutesSeconds(int miliseconds) {
    var absmiliseconds = miliseconds.abs();
    Duration duration = Duration(milliseconds: absmiliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String twoDigitMilliSeconds = twoDigits(duration.inSeconds.remainder(100));
    if (miliseconds > 0)
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    else
      return "-${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  final Map<String, KeySettings> keySetting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: StreamBuilder(
            stream: widget.channelMobStatistics.stream,
            builder: (context, snapshotStatic) {
              if (snapshotStatic.hasData) {
                if (firstTimeStatic) {
                  firstTimeStatic = false;
                }
                StatMobile ps = StatMobile.fromJson(
                    json.decode(snapshotStatic.data as String));
                return StreamBuilder(
                    stream: widget.channelPhysics.stream,
                    builder: (context, snapshotPhysics) {
                      if (snapshotPhysics.hasData) {
                        if (firstTimePhysics) {
                          widget.channelPhysics.sink
                              .add('fuel,brakeBias,speedKmh');
                          firstTimePhysics = false;
                        }
                        PageFilePhysics pp = PageFilePhysics.fromJson(
                            json.decode(snapshotPhysics.data as String));
                        maxSpeed =
                            pp.speedKmh > maxSpeed ? pp.speedKmh : maxSpeed;
                        minSpeed =
                            pp.speedKmh < minSpeed ? pp.speedKmh : minSpeed;
                        return StreamBuilder(
                            stream: widget.channelGraphics.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (firstTimeGraphics) {
                                  widget.channelGraphics.sink.add(
                                      'packetId,isInPit,isInPitLane,TC,TCCut,EngineMap,ABS,fuelXLap,rainLights,flashingLights,lightsStage,wiperLV,normalizedCarPosition,lastSectorTime,iCurrentTime');
                                  firstTimeGraphics = false;
                                }

                                PageFileGraphics pg = PageFileGraphics.fromJson(
                                    json.decode(snapshot.data as String));
                                if (pg.normalizedCarPosition < lastPos) {
                                  maxSpeed = 0.0;
                                  minSpeed = 500.0;
                                  lastPos = 0.0;
                                }
                                lastPos = pg.normalizedCarPosition;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Lights(
                                                    pageFileGraphics: pg,
                                                  )),
                                              pg.isInPit == 0
                                                  ? Expanded(
                                                      flex: 2,
                                                      child: PlusMinus(
                                                          (pg.engineMap! + 1)
                                                              .toDouble(),
                                                          'M A P',
                                                          Colors.yellow,
                                                          keySetting['MAP+']!,
                                                          keySetting['MAP-']!))
                                                  : Expanded(
                                                      flex: 2,
                                                      child: Ignition(
                                                          pageFileGraphics:
                                                              pg)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(flex: 1, child: MFD()),
                                              pg.isInPit == 0
                                                  ? Expanded(
                                                      flex: 2,
                                                      child: PlusMinus(
                                                          (pg.tc!).toDouble(),
                                                          'T C',
                                                          Colors
                                                              .lightBlueAccent,
                                                          keySetting['TC+']!,
                                                          keySetting['TC-']!))
                                                  : Expanded(
                                                      flex: 2,
                                                      child: Starter(
                                                        pageFileGraphics: pg,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  flex: 1, child: Wipers(pg)),
                                              pg.isInPit == 0
                                                  ? Expanded(
                                                      flex: 2,
                                                      child: PlusMinus(
                                                          (pg.abs!).toDouble(),
                                                          'A B S',
                                                          Colors
                                                              .lightGreenAccent,
                                                          keySetting['ABS+']!,
                                                          keySetting['ABS-']!),
                                                    )
                                                  : Expanded(
                                                      flex: 2,
                                                      child: Container(),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 12.0, 0, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Container()),
                                                pg.isInPit == 0
                                                    ? Expanded(
                                                        flex: 2,
                                                        child: PlusMinus(
                                                            pp.brakeBias *
                                                                100.0,
                                                            'B R A K E   B I A S',
                                                            Colors.lightGreen,
                                                            keySetting['BB+']!,
                                                            keySetting['BB-']!))
                                                    : Expanded(
                                                        flex: 2,
                                                        child: Container(),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 20, 5, 10),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            color: Colors.white10,
                                            child: DataTable(
                                              dataRowHeight: 16.0,
                                              columns: [
                                                DataColumn(
                                                    label: Text(
                                                        'Recalculated after start line [' +
                                                            (100 -
                                                                    pg.normalizedCarPosition *
                                                                        100)
                                                                .toInt()
                                                                .toString() +
                                                            '%]',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.yellow,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                DataColumn(
                                                    label: Text('Value',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.yellow,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ],
                                              rows: [
                                                DataRow(cells: [
                                                  DataCell(Text(
                                                      (ps.fuelEstForNextMiliseconds
                                                                      .toInt() -
                                                                  ps.sessionTimeLeft
                                                                      .toInt() <
                                                              0)
                                                          ? 'Not enought fuel [hh:mm:ss]'
                                                          : 'Running out after session ends',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                  DataCell(Text(
                                                      _printDurationHoursMinutesSeconds(ps
                                                              .fuelEstForNextMiliseconds
                                                              .toInt() -
                                                          ps.sessionTimeLeft
                                                              .toInt()),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text(
                                                      'Fuel for next [hh:mm:ss]',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                  DataCell(Text(
                                                      (ps.fuelEstForNextMiliseconds
                                                                      .toInt() -
                                                                  pg.iCurrentTime
                                                                      .toInt()) <
                                                              0
                                                          ? '00:00:00'
                                                          : _printDurationHoursMinutesSeconds(ps
                                                                  .fuelEstForNextMiliseconds
                                                                  .toInt() -
                                                              pg.iCurrentTime
                                                                  .toInt()),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text(
                                                      'Fuel for next [laps]',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                  DataCell(Text(
                                                      (ps.fuelEFNLapsOnEnd +
                                                              (ps.fuelAdded /
                                                                  ps
                                                                      .fuelAVGPerLap))
                                                          .toStringAsFixed(1),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text(
                                                      'Avg fuel consumed [l/min]',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                  DataCell(Text(
                                                      (ps.fuelAVGPerMinute)
                                                          .toStringAsFixed(3),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text(
                                                      'Avg fuel consumed [l/lap]',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                  DataCell(Text(
                                                      (pg.fuelXLap!
                                                          .toStringAsFixed(3)),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text(
                                                      'Fuel needed to finish race [l]',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                  DataCell(Text(
                                                      ps.fuelNTFOnEnd
                                                          .toStringAsFixed(3),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                ]),
                                                DataRow(cells: [
                                                  DataCell(Text('Fuel [kg]',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                  DataCell(Text(
                                                      (pp.fuel != null
                                                          ? pp.fuel!
                                                              .toStringAsFixed(
                                                                  3)
                                                          : "0"),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal))),
                                                ]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 300,
                            width: 400,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: const CircularProgressIndicator(),
                                ),
                                Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.circular(Consts.padding),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10.0,
                                        offset: const Offset(0.0, 10.0),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        Consts.title,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    });
              } else {
                return Container(
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
            }),
      ),
    );
  }

  @override
  void dispose() {
    widget.channelGraphics.sink.close();
    widget.channelPhysics.sink.close();
    super.dispose();
  }
}
