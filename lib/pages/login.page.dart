import 'package:acc_manager/main.dart';
import 'package:acc_manager/pages/home.page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  Future<String> _port = conf.getServerSetting("PORT");
  Future<String> _ip = conf.getServerSetting("IP");

  final myControllerIP = TextEditingController();
  final myControllerPort = TextEditingController();

  @override
  void initState() {
    super.initState();
    //myControllerIP.addListener(_printLatestValue);
    //myControllerPort.addListener(_printLatestValue);
  }
/*
  _printLatestValue() {
    print("IP: ${myControllerIP.text}");
    print("Port: ${myControllerPort.text}");
  }
*/
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myControllerIP.dispose();
    myControllerPort.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new AssetImage("lib/assets/acc_2.jpg"),
                  colorFilter:
                      ColorFilter.mode(Colors.black26, BlendMode.darken),
                  alignment: FractionalOffset.topRight,
                  fit: BoxFit.cover)),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  FutureBuilder<String>(
                      future: _ip,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              myControllerIP.text = snapshot.data;
                              return TextFormField(
                                maxLength: 15,
                                autovalidateMode: AutovalidateMode.always,
                                controller: myControllerIP,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter IP';
                                  } else {
                                    if (!validator.ip(value)) return 'IP address is not valid';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900)),
                                decoration: InputDecoration(
                                  fillColor: Colors.lightBlueAccent,
                                  labelText: 'IP',
                                  labelStyle: GoogleFonts.comfortaa(
                                      textStyle: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900)),
                                ),
                              );
                            }
                        }
                      }),
                  FutureBuilder(
                      future: _port,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              myControllerPort.text = snapshot.data;
                              return TextFormField(
                                maxLength: 5,
                                autovalidateMode: AutovalidateMode.always,
                                controller: myControllerPort,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter port (8080 default)';
                                  }else{
                                    const pattern = r'^[0-9]{1,5}$';
                                    final regExp = RegExp(pattern);
                                    if (!regExp.hasMatch(value)) return 'Please enter valid port. (8080 default)';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900)),
                                decoration: InputDecoration(
                                  fillColor: Colors.lightBlueAccent,
                                  labelText: 'Port',
                                  labelStyle: GoogleFonts.comfortaa(
                                      textStyle: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900)),
                                ),
                              );
                            }
                        }
                      }),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            conf.save("IP", myControllerIP.text);
                            conf.save("PORT", myControllerPort.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(context),
                                ));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10, left: 160, right: 10, bottom: 0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset('lib/assets/ACL_LOGO_WHITE-RED.png',
                          alignment: Alignment.topRight,
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.white30,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(Consts.padding),
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
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 8.0;

  static const String title = "info";
  static const String description =
      'Make sure you have run the "acc-manager-server" application on the same computer where Assetto Corsa Competizione is running.\n\n'
    + 'You can download the "acc-manager-server" program from:\n'
    + 'https://github.com/madmak2005/acc-manager-server';
}
