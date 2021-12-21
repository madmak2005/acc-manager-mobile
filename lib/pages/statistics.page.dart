import 'dart:convert';

import 'package:acc_manager/common/StatSession.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:intl/intl.dart';

import 'dart:developer';

import 'login.page.dart';

bool firstTimeStatistics= true;

class StatisticsPage extends StatelessWidget {
  StatisticsPage(){
    firstTimeStatistics = true;
  }
  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Statistics"),

        ),
        body: MyStatisticsPage(
          channelStatistics: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
              'ws://${conf.serverIP}:${conf.serverPort}/acc/statistics'))
              : IOWebSocketChannel.connect(Uri.parse(
              'ws://${conf.serverIP}:${conf.serverPort}/acc/statistics')),));
  }
}

class MyStatisticsPage extends StatefulWidget {
  final WebSocketChannel channelStatistics;

  MyStatisticsPage({Key? key, required this.channelStatistics})
      : super(key: key);

  @override
  _MyStatisticsPageState createState() => _MyStatisticsPageState();
}

class _MyStatisticsPageState extends State<MyStatisticsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: StreamBuilder(
        stream: widget.channelStatistics.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(firstTimeStatistics) {
              widget.channelStatistics.sink.add('');
              firstTimeStatistics = false;
            }
            StatSession pp = StatSession.fromJson(json.decode(snapshot.data as String));
            DateFormat formatter = DateFormat('Hms');
            DateTime fuelEstForNextMiliseconds = new DateTime.fromMicrosecondsSinceEpoch(1);
            //DateTime fuelEstForNextMiliseconds = new DateTime.fromMicrosecondsSinceEpoch(pp.currentLap.fuelEstForNextMiliseconds.truncate());
            if (pp.lastLap == null ){
              log(pp.toString());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                color: Colors.white10,
                child: DataTable(
                  //dataRowHeight: 32.0,
                  columnSpacing: 8.0,
                  horizontalMargin: 1.0,
                  columns: [
                    DataColumn(
                        label: Text('Data',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 16,
                                fontWeight:
                                FontWeight.bold))),
                    DataColumn(
                        label: Text('Value',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 16,
                                fontWeight:
                                FontWeight.bold))),
                  ],
                  rows: [

                    DataRow(cells: [
                      DataCell(Text('Lap No.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          (pp.currentLap!.lapNo.toString()),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('FL, FR, RL, RR  [PSI]',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          '${(pp.currentLap!.pFL).toStringAsFixed(2)} ${(pp.currentLap!.pFR).toStringAsFixed(2)} ${(pp.currentLap!.pRL).toStringAsFixed(2)} ${(pp.currentLap!.pRR).toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('FL, FR, RL, RR [°C]',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          '${(pp.currentLap!.tFL).toStringAsFixed(2)} ${(pp.currentLap!.tFR).toStringAsFixed(2)} ${(pp.currentLap!.tRL).toStringAsFixed(2)} ${(pp.currentLap!.tRR).toStringAsFixed(2)} ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                          'Road temp [°C]',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          (pp.currentLap!.roadTemp).toStringAsFixed(1),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Fuel [kg]',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          (pp.currentLap!.fuelLeftOnEnd.toStringAsFixed(3)),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Enough fuel for next [laps]',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          (pp.currentLap!.fuelEFNLapsOnEnd.toStringAsFixed(1)),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),

                    DataRow(cells: [
                      DataCell(Text('Enough fuel for next [time]',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          (formatter.format(fuelEstForNextMiliseconds)),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),
                  ],
                ),
              ),
            );
          }else{

            return
              Container(
                  color: Colors.black,
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
                      )
                  )
              );

          }
        },
      )

    );
  }
}

class ButtonWidget extends StatelessWidget {
  Icon? icon;
  String? action;
  ButtonWidget(Icon icon, String action){
   this.icon = icon;
   this.action = action;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
          onTap: () => RESTVirtualKeyboard.sendkey(action!),
          child: icon),
    );
  }

}
