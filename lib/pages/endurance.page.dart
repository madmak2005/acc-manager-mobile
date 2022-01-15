import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:acc_manager/pages/home.page.dart';
import 'package:acc_manager/providers/providers.dart';
import 'package:acc_manager/services/LocalStreams.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acc_manager/main.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_page.dart';

class EndurancePage extends StatefulWidget {
  EndurancePage({Key? key}) : super(key: key);

  @override
  _EnduranceState createState() => _EnduranceState();
}

class _EnduranceState extends State<EndurancePage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  String team = "";
  String passwd = "";

  bool isEnabled = false;
  bool isAuth = false;

  bool localStream = false;
  bool googleStream = false;
  StreamSubscription? subscriptionLocal;
  StreamSubscription? subscriptionGoogle;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isAuth = false;
        });
      } else {
        print('User is signed in!');
        setState(() {
          isAuth = true;
        });
      }
    });

    subscriptionLocal = LocalStreams.streamLocal.listen((value) {
      setState(() {
        log("------------local stream: " + value.toString());
        localStream = value;
      });
    });

    subscriptionGoogle = LocalStreams.streamGoogle.listen((value) {
      setState(() {
        log("------------google stream: " + value.toString());
        googleStream = value;
      });
    });

    LocalStreams.resendStatuses();
    isEnabled = false;

    // Start listening to changes.
    myController1.addListener(_setConfigTeam);
    myController2.addListener(_setConfigPasswd);

    conf.getServerSetting("TEAM").then((value) => myController1.text = value);
    conf.getServerSetting("PASSWD").then((value) => myController2.text = value);

    print('isAuth:' + isAuth.toString());
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController1.dispose();
    myController2.dispose();

    if (subscriptionLocal != null) {
      log("--------UNSUBSCRIBE LOCAL--------");
      subscriptionLocal!.cancel();
      //LocalStreams.controller.close();
    } else {
      log("--------NO SUBSCRIBSION LOCAL--------");
    }
    if (subscriptionGoogle != null) {
      log("--------UNSUBSCRIBE GOOGLE--------");
      subscriptionGoogle!.cancel();
      //LocalStreams.controller.close();
    } else {
      log("--------NO SUBSCRIBSION GOOGLE--------");
    }

    super.dispose();
  }

  void _setConfigTeam() {
    team = myController1.text;
    log('${myController1.text}');
    setState(() {
      if (team.length >= 4 && passwd.length >= 4)
        isEnabled = true;
      else
        isEnabled = false;
    });
  }

  void _setConfigPasswd() {
    passwd = myController2.text;
    log('${myController2.text}');
    setState(() {
      if (team.length >= 4 && passwd.length >= 4)
        isEnabled = true;
      else
        isEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Endurance activation: team'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LoginPage(),
            TextFormField(
              enabled: isAuth,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter CODE (4 to 40 capital letters)';
                } else {
                  const pattern = r'^[A-Z]{4,40}$';
                  final regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value))
                    return 'Please enter CODE (4 to 40 capital letters)';
                }
                return null;
              },
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter team code',
              ),
              controller: myController1,
            ),
            TextFormField(
              enabled: isAuth,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter pin (4 to 8 digits)';
                } else {
                  const pattern = r'^[0-9]{4,8}$';
                  final regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value))
                    return 'Please enter pin (4 to 8 digits)';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter PIN',
              ),
              controller: myController2,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: googleStream
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[300],
                          ),
                          child: Text(
                            "Stop",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: (isEnabled && isAuth)
                              ? _leaveButtonPressed
                              : null,
                        )
                      : ElevatedButton(
                          child: Text(
                            "Join team",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed:
                              (isEnabled && isAuth) ? _joinButtonPressed : null,
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 1, child: Text("Google Cloud: ")),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.google),
                                color:
                                    googleStream ? Colors.green : Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 1, child: Text("Local: ")),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.wifi),
                                color: localStream ? Colors.green : Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: new BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(2),
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
                      "Manual",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.lightBlue,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'This function is used to exchange lap information between members of the same team. On the "Current session" tab you will be able to access your own data and the data of other team members. Each team member must provide the same team code and PIN. Simple combinations such as "ABCD" and "1234" should not be given because you could connect to a team that would choose the same simple combinations. There are no advanced authorization methods.',
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
            ),
          ],
        ),
      ),
    );
  }

  _joinButtonPressed() {
    if (team.isNotEmpty && passwd.isNotEmpty) {
      conf.save("TEAM", team);
      conf.save("PASSWD", passwd);
      LocalStreams.initStreams(team, passwd);
    }
  }

  _leaveButtonPressed() {
    if (team.isNotEmpty && passwd.isNotEmpty) {
      LocalStreams.stopStreams();
    }
  }
}
