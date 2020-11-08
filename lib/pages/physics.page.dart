import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/cards/mediaCard.dart';
import 'package:virtual_keyboard/common/Configuration.dart';
import 'package:virtual_keyboard/common/PageFilePhysics.dart';
import 'package:virtual_keyboard/services/RESTVirtualKeyboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:virtual_keyboard/main.dart';

class PhysicsPage extends StatelessWidget {
  PhysicsPage();
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
        body: MyPhysicsPage(channel: IOWebSocketChannel.connect('ws://${conf.serverIP}:${conf.serverPort}/acc/physics'),));
  }
}

class MyPhysicsPage extends StatefulWidget {
  final WebSocketChannel channel;

  MyPhysicsPage({Key key,@required this.channel})
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
        stream: widget.channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PageFilePhysics p = PageFilePhysics.fromJson(json.decode(snapshot.data));
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                children: [
                  Text("PacketID:"),
                  Text(p.packetId.toString()),
                ],
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
