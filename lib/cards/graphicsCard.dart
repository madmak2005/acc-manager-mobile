import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard/common/KeySettings.dart';
import 'package:virtual_keyboard/pages/audio.page.dart';
import 'package:virtual_keyboard/pages/graphics.page.dart';

import '../main.dart';

class GraphicsCard extends StatelessWidget {
  Future<Map<String, KeySettings>> _allKeys = conf.getAllKeys();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _allKeys,
        builder: (BuildContext context, AsyncSnapshot<Map<String,KeySettings>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Map<String,KeySettings> allKey = snapshot.data;
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
                          'Graphics',
                          style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                        ),
                        dense: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GraphicsPage(allKey)));
                        }),
                  ),
                );
              }
          }
        });
  }
}
