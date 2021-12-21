import 'package:acc_manager/pages/widgets/BGImages.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AudioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Audio"),

        ),
        body: MyAudioPage());
  }
}

class MyAudioPage extends StatefulWidget {

  @override
  _MyAudioPageState createState() => _MyAudioPageState();
}

class _MyAudioPageState extends State<MyAudioPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: new AssetImage(getBGImage()),
                alignment: FractionalOffset.centerRight,
                fit: BoxFit.cover)),
        child: GridView.count(
          crossAxisCount: 4,
          padding: EdgeInsets.all(12.0),
          childAspectRatio: 8.0 / 4.0,
          children:
            <Widget>[
              ButtonWidget(new Icon(Icons.skip_previous),"MEDIA_PREV_TRACK"),
              ButtonWidget(new Icon(Icons.play_arrow),"MEDIA_PLAY_PAUSE"),
              ButtonWidget(new Icon(Icons.stop),"MEDIA_STOP"),
              ButtonWidget(new Icon(Icons.skip_next),"MEDIA_NEXT_TRACK"),
              ButtonWidget(new Icon(Icons.volume_down),"VOLUME_DOWN"),
              ButtonWidget(new Icon(Icons.volume_up),"VOLUME_UP"),
            ],
        ),
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
