import 'dart:io';

import 'package:acc_manager/main.dart';
import 'package:http/http.dart' as http;

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

}