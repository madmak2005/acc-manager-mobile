import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:virtual_keyboard/pages/home.page.dart';
import 'package:virtual_keyboard/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LocalStorage storage = new LocalStorage('acc_manager');
  final _formKey = GlobalKey<FormState>();
  final myControllerIP = TextEditingController();
  final myControllerPort = TextEditingController();

  @override
  void initState() {
    super.initState();
    myControllerIP.addListener(_printLatestValue);
    myControllerPort.addListener(_printLatestValue);
    print(storage.getItem('IP'));
    myControllerIP.text = storage.getItem('IP');
    myControllerPort.text = storage.getItem('PORT');
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
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.black, Colors.black]),
          ),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextFormField(
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
                  ),
                  TextFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          storage.setItem("IP", myControllerIP.text);
                          storage.setItem("PORT", myControllerPort.text);
                          conf.serverIP = myControllerIP.text;
                          conf.serverPort = myControllerPort.text;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage(context),));
                        }
                      },
                      child: Text('Submit'),
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
