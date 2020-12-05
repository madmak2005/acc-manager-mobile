import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:acc_manager/cards/mediaCard.dart';
import 'package:acc_manager/common/Configuration.dart';
import 'package:acc_manager/common/PageFilePhysics.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:acc_manager/main.dart';

bool firstTimePhysics;

class PhysicsPage extends StatelessWidget {
  PhysicsPage(){
    firstTimePhysics = true;
  }
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Physics"),

        ),
        body: MyPhysicsPage(
          channelPhysics: kIsWeb
              ? WebSocketChannel.connect(Uri.parse(
              'ws://${conf.serverIP}:${conf.serverPort}/acc/physics'))
              : IOWebSocketChannel.connect(Uri.parse(
              'ws://${conf.serverIP}:${conf.serverPort}/acc/physics')),));
  }
}

class MyPhysicsPage extends StatefulWidget {
  final WebSocketChannel channelPhysics;

  MyPhysicsPage({Key key, @required this.channelPhysics})
      : super(key: key);

  @override
  _MyPhysicsPageState createState() => _MyPhysicsPageState();
}

class _MyPhysicsPageState extends State<MyPhysicsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: StreamBuilder(
        stream: widget.channelPhysics.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(firstTimePhysics) {
              widget.channelPhysics.sink.add('');
              firstTimePhysics = false;
            }
            PageFilePhysics pp = PageFilePhysics.fromJson(json.decode(snapshot.data));
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
                      DataCell(Text('Brake FL, FR, RL, RR  [°C]',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          '${(pp.brakeTemp[0]).toStringAsFixed(1)} ${(pp.brakeTemp[1]).toStringAsFixed(1)} ${(pp.brakeTemp[2]).toStringAsFixed(1)} ${(pp.brakeTemp[3]).toStringAsFixed(1)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Damage front, rear, left, right, centre',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal))),
                      DataCell(Text(
                          '${(pp.carDamage[0]).toStringAsFixed(3)} ${(pp.carDamage[1]).toStringAsFixed(3)} ${(pp.carDamage[2]).toStringAsFixed(3)} ${(pp.carDamage[3]).toStringAsFixed(3)} ${(pp.carDamage[4]).toStringAsFixed(3)}',
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
                          (pp.roadTemp).toStringAsFixed(1),
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
                          (pp.fuel.toStringAsFixed(3)),
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
            );
          }
        },
      )

    );
  }
}

class ButtonWidget extends StatelessWidget {
  Icon icon;
  String action;
  ButtonWidget(Icon icon, String action){
   this.icon = icon;
   this.action = action;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
          onTap: () => RESTVirtualKeyboard.sendkey(action),
          child: icon),
    );
  }

}
