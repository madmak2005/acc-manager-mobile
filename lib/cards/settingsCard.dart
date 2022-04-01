import 'dart:developer';

import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/pages/settings.page.dart';
import 'package:acc_manager/services/LocalStreams.dart';
import 'package:acc_manager/services/RESTSessions.dart';
import 'package:acc_manager/services/RESTVirtualKeyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class SettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        color: Colors.grey.withOpacity(0.6),
        child: ListTile(
            leading: Icon(
              Icons.admin_panel_settings_outlined,
              color: Colors.pink,
            ),
            title: Text(
              'Settings',
              style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w900)),
            ),
            dense: true,
            onTap: () {
              LocalStreams.controllerBackToHomePage.add(false);

              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage(context)))
                  .then((value) => goBack());
            }),
      ),
    );
  }
}

goBack() {
  LocalStreams.controllerBackToHomePage.add(true);
  conf.getKey('SAVE RPLY').then((_kSave) => {sendKey(_kSave)});
  conf
      .getValueFromStore('autosave')
      .then((value) => sendAutoSaveActivity(value));
}

sendKey(KeySettings kSave) {
  if (kSave.key != '') {
    log('_kSave ${kSave.key}');
    RESTSessions.setAutoSaveKey(kSave.key)
        .then((value) => log(value.toString()));
    //RESTVirtualKeyboard.sendkey(kSave.key);
  }
}

sendAutoSaveActivity(String value) {
  if (value != '') {
    log('_autoSaveActivity $value');
    RESTSessions.setAutoSaveActivity(value);
  }
}
