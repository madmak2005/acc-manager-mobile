import 'package:acc_manager/common/Configuration.dart';
import 'package:acc_manager/pages/login.page.dart';
import 'package:acc_manager/providers/auth_provider.dart';
import 'package:acc_manager/providers/chat_provider.dart';
import 'package:acc_manager/providers/home_provider.dart';
import 'package:acc_manager/providers/setting_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Configuration conf = new Configuration();
//late BuildContext ctx;

List<String> sentLaps = [];
PackageInfo packageInfo = PackageInfo(
  appName: 'Unknown',
  packageName: 'Unknown',
  version: 'Unknown',
  buildNumber: 'Unknown',
  buildSignature: 'Unknown',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /*
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  */
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    //prefs.remove('SAVE RPLY');
    //prefs.remove('STARTER');
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(),
              prefs: this.prefs,
              firebaseFirestore: this.firebaseFirestore,
            ),
          ),
          Provider<SettingProvider>(
            create: (_) => SettingProvider(
              prefs: this.prefs,
              firebaseFirestore: this.firebaseFirestore,
              firebaseStorage: this.firebaseStorage,
            ),
          ),
          Provider<HomeProvider>(
            create: (_) => HomeProvider(
              firebaseFirestore: this.firebaseFirestore,
            ),
          ),
          Provider<ChatProvider>(
            create: (_) => ChatProvider(
              prefs: this.prefs,
              firebaseFirestore: this.firebaseFirestore,
              firebaseStorage: this.firebaseStorage,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'ACC Manager',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            unselectedWidgetColor: Colors.grey,
          ),
          home: LoginPage(),
        ));
  }
}
