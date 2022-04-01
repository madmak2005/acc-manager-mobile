import 'package:acc_manager/pages/session.page.dart';
import 'package:acc_manager/services/LocalStreams.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        color: Colors.grey.withOpacity(0.6),
        child: ListTile(
            leading: Icon(
              Icons.addchart,
              color: Colors.pink,
            ),
            title: Text(
              'Current Session',
              style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w900)),
            ),
            dense: true,
            onTap: () {
              LocalStreams.controllerBackToHomePage.add(false);
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SessionPage()))
                  .then((value) =>
                      LocalStreams.controllerBackToHomePage.add(true));
            }),
      ),
    );
  }
}
