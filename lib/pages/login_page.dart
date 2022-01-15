import 'package:acc_manager/constants/app_constants.dart';
import 'package:acc_manager/constants/constants.dart';
import 'package:acc_manager/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

import './widgets/widgets.dart';
import 'home.page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isAuth = false;

  @override
  initState() {
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
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }
    return isAuth
        ? Stack(
            children: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () async {
                    await authProvider.handleSignOut();
                  },
                  child: Text(
                    'Sign out from Google',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.green.withOpacity(0.8);
                        return Colors.green;
                      },
                    ),
                    splashFactory: NoSplash.splashFactory,
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.fromLTRB(30, 15, 30, 15),
                    ),
                  ),
                ),
              ),
              // Loading
              Positioned(
                child: authProvider.status == Status.authenticating
                    ? LoadingView()
                    : SizedBox.shrink(),
              ),
            ],
          )
        : Stack(
            children: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () async {
                    bool isSuccess = await authProvider.handleSignIn();
                    if (isSuccess) {
                      /*
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(context),
                  ),
                );
                */
                    }
                  },
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xffdd4b39).withOpacity(0.8);
                        return Color(0xffdd4b39);
                      },
                    ),
                    splashFactory: NoSplash.splashFactory,
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.fromLTRB(30, 15, 30, 15),
                    ),
                  ),
                ),
              ),
              // Loading
              Positioned(
                child: authProvider.status == Status.authenticating
                    ? LoadingView()
                    : SizedBox.shrink(),
              ),
            ],
          );
  }
}
