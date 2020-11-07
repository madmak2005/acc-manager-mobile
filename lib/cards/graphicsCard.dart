import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_keyboard/pages/audio.page.dart';
import 'package:virtual_keyboard/pages/graphics.page.dart';

class GraphicsCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        child: ListTile(
          leading: Icon(Icons.add_photo_alternate_outlined,
            color: Colors.pink,),
          title: Text(
            'Graphics',
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w900)),
          ),
          tileColor: Colors.lightBlue,
            dense: true,
          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GraphicsPage()));
          }
        ),
      ),
    );
  }
}
