import 'dart:io';

import 'package:acc_manager/common/StatMobile.dart';
import 'package:acc_manager/common/StatSession.dart';
import 'package:acc_manager/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show ascii, base64, base64Encode, json, jsonDecode, utf8;

class RESTSessions {
  static void getCurrentSession() async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
      queryParameters = {'range': 'currentSession', };

    var address = conf.serverIP+":"+conf.serverPort;
    var uri = Uri.http('$address', "/getSession", queryParameters);
    http.get(uri, headers: headers);
  }

  static Future<http.Response> saveSessions() async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    var address = conf.serverIP+":"+conf.serverPort;
    var uri = Uri.http('$address', "/save", queryParameters);
    return http.get(uri, headers: headers);
  }

  static Future<List<StatSession>> getPreviousSessions() async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters = {};

    var address = conf.serverIP + ":" +conf.serverPort;
    var uri = Uri.http('$address', "/getMobileSessionList", queryParameters);
    final res = await http.get(uri, headers: headers);
    var statList = json.decode(res.body) as List;
    return statList.map((list) => StatSession.fromJson(list)).toList();

  }

  static Future<List<StatMobile>> getPreviousSession(int internalSessionIndex) async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters = {'internalSessionIndex': internalSessionIndex.toString(), };
    var address = conf.serverIP+":"+conf.serverPort;
    var uri = Uri.http('$address', "/getMobileSession", queryParameters);
    final res = await http.get(uri, headers: headers);
    var statList = json.decode(res.body) as List;
    return statList.map((list) => StatMobile.fromJson(list)).toList();
  }


}