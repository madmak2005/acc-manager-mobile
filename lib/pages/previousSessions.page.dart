import 'dart:convert';

import 'package:acc_manager/common/StatSession.dart';
import 'package:acc_manager/pages/previousSession.page.dart';
import 'package:acc_manager/services/RESTSessions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousSessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Previous sessions'),
      ),
      // Display our list widget
      body: Center(child: ShowFutureThings()),
    );
  }
}

class ShowFutureThings extends StatefulWidget {
  @override
  _ShowFutureThingsState createState() => _ShowFutureThingsState();

}

Future<List<StatSession>> getHttpData() async {
  return RESTSessions.getPreviousSessions();
}



class _ShowFutureThingsState extends State<ShowFutureThings> {

  Future<void> _getData() async {
    setState(() {
      getHttpData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StatSession>>(
      future: getHttpData(),
      initialData: [],
      builder:
          (BuildContext context, AsyncSnapshot<List<StatSession>> snapshot) {
        return snapshot.data != null ? RefreshIndicator(
          onRefresh: _getData,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  new ListTile(
                    title: Row(
                      children: [
                        new Text(
                  (     snapshot.data![index].session_TYPENAME + ": ").toUpperCase() +
                          snapshot.data![index].car.carModel
                              .toUpperCase()
                              .replaceAll("_", " "),
                          style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900)),
                        ),
                        new Text(
                          " @ " +
                              snapshot.data![index].car.track
                                  .toUpperCase()
                                  .replaceAll("_", " "),
                          style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            new Text(
                              "Fuel per lap: ",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                              snapshot.data![index].fuelAVG5Laps>0? snapshot.data![index].fuelAVG5Laps
                                  .toStringAsFixed(2) : snapshot.data![index].fuelAVG3Laps > 0 ? snapshot.data![index].fuelAVG3Laps.toStringAsFixed(2) : "?",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                              "  Fuel per minute: ",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                            snapshot.data![index].avgLapTime5 != 0 ? ((snapshot.data![index].fuelAVG5Laps) / (snapshot.data![index].avgLapTime5 / 1000 / 60)).toStringAsFixed(3) :
                            snapshot.data![index].avgLapTime3 != 0 ? ((snapshot.data![index].fuelAVG3Laps) / (snapshot.data![index].avgLapTime3 / 1000 / 60)).toStringAsFixed(3) : "?",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                              "  FuelXLap [ACC]: ",
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900)),
                            ),
                            new Text(
                              snapshot.data![index].fuelXLap.toStringAsFixed(2),
                              style: GoogleFonts.comfortaa(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            new Text("Laps: ",
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900))),
                            new Text(snapshot.data![index].internalLapIndex == 0? "0" : (snapshot.data![index].internalLapIndex -1).toString(),
                                style: GoogleFonts.comfortaa(
                                    textStyle: TextStyle(
                                        color: Colors.green,
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900))),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviousSessionPage(
                                  snapshot.data![index].internalSessionIndex)));
                    },
                  ),
                  Divider(color: Colors.blue),
                ],
              );
            },
          ),
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
