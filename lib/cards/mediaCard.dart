import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:acc_manager/pages/audio.page.dart';

class MediaCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6.0,
        color: Colors.grey.withOpacity(0.6),
        child: ListTile(
          leading: Icon(Icons.add_box_outlined,
            color: Colors.pink,),
          title: Text(
            'Media',
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w900)),
          ),
            dense: true,
          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AudioPage()));
          }
        ),
      ),
    );
  }
}
