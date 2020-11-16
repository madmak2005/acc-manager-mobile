import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard/pages/home.page.dart';
import 'package:virtual_keyboard/main.dart';

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
    myControllerIP.addListener(_printLatestValue);
    myControllerPort.addListener(_printLatestValue);
  }

  _printLatestValue() {
    print("IP: ${myControllerIP.text}");
    print("Port: ${myControllerPort.text}");
  }

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
                  alignment: FractionalOffset.centerRight,
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
                                controller: myControllerIP,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter IP';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900)),
                                decoration: InputDecoration(
                                  fillColor: Colors.lightBlueAccent,
                                  labelText: 'IP',
                                  labelStyle: GoogleFonts.comfortaa(
                                      textStyle: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 22,
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
                                controller: myControllerPort,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Port (8080 default)';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900)),
                                decoration: InputDecoration(
                                  fillColor: Colors.lightBlueAccent,
                                  labelText: 'Port',
                                  labelStyle: GoogleFonts.comfortaa(
                                      textStyle: TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 22,
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
                            log('SAVE1');
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
