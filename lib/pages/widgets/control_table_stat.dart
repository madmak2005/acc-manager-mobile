import 'package:acc_manager/common/PageFileGraphics.dart';
import 'package:acc_manager/common/PageFilePhysics.dart';
import 'package:acc_manager/common/StatMobile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class statTable extends StatefulWidget {
  StatMobile ps;
  PageFileGraphics pg;
  PageFilePhysics pp;

  statTable({Key? key, required this.ps, required this.pg, required this.pp})
      : super(key: key);

  @override
  _statTableState createState() => _statTableState();
}

class _statTableState extends State<statTable> {
  String _printDurationHoursMinutesSeconds(int miliseconds) {
    var absmiliseconds = miliseconds.abs();
    Duration duration = Duration(milliseconds: absmiliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String twoDigitMilliSeconds = twoDigits(duration.inSeconds.remainder(100));
    if (miliseconds >= 0)
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    else
      return "-${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    PageFileGraphics _pg = widget.pg;
    StatMobile _ps = widget.ps;
    PageFilePhysics _pp = widget.pp;
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white10,
      child: DataTable(
        dataRowHeight: 16.0,
        columns: [
          DataColumn(
              label: Text(
                  'Recalculated after start line [' +
                      (100 - _pg.normalizedCarPosition * 100)
                          .toInt()
                          .toString() +
                      '%]',
                  style: TextStyle(
                      color: _ps.isValidLap ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Value',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 12,
                      fontWeight: FontWeight.bold))),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(
                (_ps.fuelEstForNextMiliseconds.toInt() -
                            _ps.sessionTimeLeft.toInt() <
                        0)
                    ? 'Not enought fuel [hh:mm:ss]'
                    : 'Running out after session ends',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
            DataCell(Text(
                _printDurationHoursMinutesSeconds(
                    _ps.fuelEstForNextMiliseconds.toInt() -
                        _ps.sessionTimeLeft.toInt()),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
          ]),
          DataRow(cells: [
            DataCell(Text('Fuel for next [hh:mm:ss]',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
            DataCell(Text(
                (_ps.fuelEstForNextMiliseconds.toInt() -
                            _pg.iCurrentTime.toInt()) <
                        0
                    ? '00:00:00'
                    : _printDurationHoursMinutesSeconds(
                        _ps.fuelEstForNextMiliseconds.toInt() -
                            _pg.iCurrentTime.toInt()),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
          ]),
          DataRow(cells: [
            DataCell(Text('Fuel for next [laps]',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
            DataCell(Text(
                (_ps.fuelEFNLapsOnEnd + (_ps.fuelAdded / _ps.fuelAVGPerLap))
                    .toStringAsFixed(1),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
          ]),
          DataRow(cells: [
            DataCell(Text('Avg fuel consumed [l/min]',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
            DataCell(Text((_ps.fuelAVGPerMinute).toStringAsFixed(3),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
          ]),
          DataRow(cells: [
            DataCell(Text('Avg fuel consumed [l/lap]',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
            DataCell(Text((_pg.fuelXLap!.toStringAsFixed(3)),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
          ]),
          DataRow(cells: [
            DataCell(Text('Fuel needed to add [l]',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
            DataCell(Text(
                (_ps.fuelNTFOnEnd - _ps.fuelLeftOnEnd)
                    .ceil()
                    .toStringAsFixed(0),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
          ]),
          DataRow(cells: [
            DataCell(Text('Fuel [kg]',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
            DataCell(Text(_pp.fuel.toStringAsFixed(3),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.normal))),
          ]),
        ],
      ),
    );
  }
}
