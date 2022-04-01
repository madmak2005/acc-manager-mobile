import 'dart:async';
import 'dart:io';

import 'package:acc_manager/common/StatMobile.dart';
import 'package:acc_manager/common/StatSession.dart';
import 'package:acc_manager/main.dart';
import 'package:acc_manager/models/application_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show ascii, base64, base64Encode, json, jsonDecode, utf8;

class RESTSessions {
  static Future<ApplicationInfo> getApplicationInfo() async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters = {};

    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/info", queryParameters);

    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 2));
      var ai = ApplicationInfo.fromJson(json.decode(response.body));
      return ai;
    } on TimeoutException catch (e) {
      print('Timeout');
      print('Error: $e');
      return ApplicationInfo(
          applicationName: 'Unknown',
          buildVersion: 'Timeout',
          buildTimestamp: 'Unknown');
    } on Error catch (e) {
      print('Error: $e');
      return ApplicationInfo(
          applicationName: 'Unknown',
          buildVersion: 'Error',
          buildTimestamp: 'Unknown');
    }
  }

  static void getCurrentSession() async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters = {
      'range': 'currentSession',
    };

    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/getSession", queryParameters);
    http.get(uri, headers: headers);
  }

  static Future<http.Response> saveSessions() async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/save", queryParameters);
    return http.get(uri, headers: headers);
  }

  static Future<String> setAutoSaveKey(String key) async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters.putIfAbsent("key", () => key);
    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/setAutoSaveKey", queryParameters);
    print('------< setAutoSaveKey >-------');
    //print(json);
    try {
      return await http
          .post(uri, headers: headers)
          .timeout(const Duration(seconds: 10))
          .toString();
    } on TimeoutException catch (e) {
      print('Timeout');
      print('Error: $e');
      return 'Timeout';
    } on Error catch (e) {
      print('Error: $e');
      return '$e';
    }
  }

  static Future<String> setAutoSaveActivity(String key) async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters.putIfAbsent("key", () => key);
    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/setAutoSaveActivity", queryParameters);
    print('------< setAutoSaveActivity >-------');
    print('------< $key >-------');
    print('---------------------');
    //print(json);
    try {
      return await http
          .post(uri, headers: headers)
          .timeout(const Duration(seconds: 10))
          .toString();
    } on TimeoutException catch (e) {
      print('Timeout');
      print('Error: $e');
      return 'Timeout';
    } on Error catch (e) {
      print('Error: $e');
      return '$e';
    }
  }

  static Future<String> importTeamLap(String json) async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/importTeamLap", queryParameters);
    print('------< IMPORTING >-------');
    //print(json);
    try {
      return await http
          .put(uri, body: json, headers: headers)
          .timeout(const Duration(seconds: 5))
          .toString();
    } on TimeoutException catch (e) {
      print('Timeout');
      print('Error: $e');
      return 'Timeout';
    } on Error catch (e) {
      print('Error: $e');
      return '$e';
    }
  }

  static Future<List<StatSession>> getPreviousSessions() async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters = {};

    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/getMobileSessionList", queryParameters);
    final res = await http.get(uri, headers: headers);
    var statList = json.decode(res.body) as List;
    return statList.map((list) => StatSession.fromJson(list)).toList();
  }

  static Future<List<StatMobile>> getPreviousSession(
      int internalSessionIndex) async {
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    queryParameters = {
      'internalSessionIndex': internalSessionIndex.toString(),
    };
    var address = conf.serverIP + ":" + conf.serverPort;
    var uri = Uri.http('$address', "/getMobileSession", queryParameters);
    final res = await http.get(uri, headers: headers);
    var statList = json.decode(res.body) as List;
    return statList.map((list) => StatMobile.fromJson(list)).toList();
  }
}
