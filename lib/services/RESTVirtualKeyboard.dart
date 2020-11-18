import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:virtual_keyboard/common/Configuration.dart';
import 'package:virtual_keyboard/main.dart';

class RESTVirtualKeyboard {
  static void sendkey(String key) async {
    log("sendkey");
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'UTF-8',
    };
    var queryParameters = new Map<String, String>();
    if (key.length == 1){ queryParameters = {'key': key,};
    }else {
      log('string: $key');
      queryParameters = {'string': key, };
    }

    var address = conf.serverIP+":"+conf.serverPort;
    var uri = Uri.http('$address', "/send", queryParameters);
    http.get(uri, headers: headers);
  }

}