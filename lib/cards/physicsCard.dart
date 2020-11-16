import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard/pages/audio.page.dart';
import 'package:virtual_keyboard/pages/graphics.page.dart';
import 'package:virtual_keyboard/pages/physics.page.dart';

class PhysicsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        color: Colors.grey.withOpacity(0.6),
        child: ListTile(
            leading: Icon(
              Icons.car_rental,
              color: Colors.pink,
            ),
            title: Text(
              'Physics',
              style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w900)),
            ),
            dense: true,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhysicsPage()));
            }),
      ),
    );
  }
}
