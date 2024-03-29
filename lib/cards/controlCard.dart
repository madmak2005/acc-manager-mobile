import 'package:acc_manager/common/KeySettings.dart';
import 'package:acc_manager/pages/control.page.dart';
import 'package:acc_manager/services/LocalStreams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class GraphicsCard extends StatelessWidget {
  final Future<Map<String, KeySettings>>? _allKeys = conf.getAllKeys();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _allKeys,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, KeySettings>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Map<String, KeySettings> allKey = snapshot.data!;
                return Container(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 6.0,
                    color: Colors.grey.withOpacity(0.6),
                    child: ListTile(
                        leading: Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Colors.pink,
                        ),
                        title: Text(
                          'Control Your Car',
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
                                  builder: (context) =>
                                      ControlPage(allKey))).then((value) =>
                              LocalStreams.controllerBackToHomePage.add(true));
                        }),
                  ),
                );
              }
          }
        });
  }
}
