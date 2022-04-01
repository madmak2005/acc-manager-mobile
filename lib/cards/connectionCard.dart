import 'dart:io';

import 'package:acc_manager/models/application_info.dart';
import 'package:acc_manager/pages/settings.page.dart';
import 'package:acc_manager/services/LocalStreams.dart';
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
    LocalStreams.streamBackToHomePage.listen((event) {
      setState(() {
        if (event)
          _appInfo = RESTSessions.getApplicationInfo();
        else
          _appInfo = Future.value(ApplicationInfo(
              applicationName: 'checking',
              buildVersion: 'checking',
              buildTimestamp: 'checking'));
      });
    });

    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        color: Colors.black.withOpacity(0.7),
        child: ListTile(
            title: Column(
              children: [
                Text(
                  'ACC Server manager connection status',
                  style: GoogleFonts.comfortaa(
                      textStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w900)),
                ),
                FutureBuilder<ApplicationInfo>(
                    future: _appInfo,
                    builder:
                        (context, AsyncSnapshot<ApplicationInfo> snapshot) {
                      if (snapshot.hasData) {
                        LocalStreams.initLocalStreamLapsToSend();
                        return Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getCorolForAI(snapshot.data!),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data!.buildVersion,
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Run ACC Server Manager running and enter correct IP and port.',
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
            dense: true,
            onTap: () {
              setState(() {
                _appInfo = RESTSessions.getApplicationInfo();
              });
            }),
      ),
    );
  }

  getCorolForAI(ApplicationInfo ai) {
    if (ai.buildVersion == 'checking') return Colors.yellow;
    if (ai.buildVersion == 'Timeout' || ai.buildVersion == 'Error')
      return Colors.red;

    return Colors.green;
  }
}
