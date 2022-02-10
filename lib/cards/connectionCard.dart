import 'package:acc_manager/models/application_info.dart';
import 'package:acc_manager/pages/settings.page.dart';
import 'package:acc_manager/services/RESTSessions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionCard extends StatefulWidget {
  @override
  _ConnectionCardState createState() => _ConnectionCardState();
}

class _ConnectionCardState extends State<ConnectionCard> {
  Future<ApplicationInfo> _appInfo = RESTSessions.getApplicationInfo();
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
            title: Column(
              children: [
                Text(
                  'Connection status',
                  style: GoogleFonts.comfortaa(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w900)),
                ),
                FutureBuilder<ApplicationInfo>(
                    future: _appInfo,
                    builder:
                        (context, AsyncSnapshot<ApplicationInfo> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!.buildVersion,
                          style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'No connection to ACC Manager',
                          style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
            dense: true,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage(context)));
            }),
      ),
    );
  }
}
