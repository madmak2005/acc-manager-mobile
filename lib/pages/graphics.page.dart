import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/common/Configuration.dart';
import 'package:virtual_keyboard/common/PageFileGraphics.dart';
import 'package:virtual_keyboard/services/RESTVirtualKeyboard.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:virtual_keyboard/main.dart';

class GraphicsPage extends StatelessWidget {
  GraphicsPage();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Graphics"),
        ),
        body:MyGraphicsPage(
          channel: IOWebSocketChannel.connect('ws://${conf.serverIP}:${conf.serverPort}/acc/graphics'),
        )
    );
  }
}

class MyGraphicsPage extends StatefulWidget {
  final WebSocketChannel channel;

  MyGraphicsPage({Key key,@required this.channel})
      : super(key: key);

  @override
  _MyGraphicsPageState createState() => _MyGraphicsPageState();
}

class _MyGraphicsPageState extends State<MyGraphicsPage> {

  Color getLightColor(PageFileGraphics pg){
    switch (pg.lightsStage){
      case 0: return Colors.grey;
      case 1: return Colors.lightGreenAccent;
      case 2: return Colors.cyanAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: widget.channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PageFileGraphics pg = PageFileGraphics.fromJson(json.decode(snapshot.data));
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                   Row(
                    children: [
                        GestureDetector(
                        onTap: () {
                          RESTVirtualKeyboard.sendkey("L");
                          //final snackBar = SnackBar(content: Text("Toggle Lights!"));
                          //Scaffold.of(context).showSnackBar(snackBar);
                          },
                        child: Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 100.0,
                          color: getLightColor(pg)
                        ),
                      ),
                    ],
                  ),
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

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
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
