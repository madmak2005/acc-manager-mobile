import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'KeySettings.dart';

final Set<String> allowedKeys = {
  'LIGHTS',
  'MAP+',
  'MAP-',
  'MAP 1',
  'MAP 2',
  'MAP 3',
  'MAP 4',
  'MAP 5',
  'MAP 6',
  'MAP 7',
  'MAP 8',
  'MAP 9',
  'MAP 10',
  'MFD',
  'TC+',
  'TC-',
  'TC 1',
  'TC 2',
  'TC 3',
  'TC 4',
  'TC 5',
  'TC 6',
  'TC 7',
  'TC 8',
  'TC 9',
  'TC 10',
  'TC2+',
  'TC2-',
  'ABS+',
  'ABS-',
  'WIPERS',
  'BB+',
  'BB-',
  'IGNITION',
  'STARTER',
  'SAVE RPLY'
};

class Configuration {
  String serverIP = "";
  String serverPort = "8080";

  String team = "";
  String passwd = "";

  var autosave = 'N';
  var keptOn = 'N';

  late Future<Map<String, KeySettings>> _keys;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<SharedPreferences> get prefs => _prefs;

  Configuration() {
    this.serverIP = "";
    this.serverPort = "8080";
    this.team = "";
    this.passwd = "";

    this._keys = initAllKeys();
  }

/*
  set serverIP(String serverIP) {
    _serverIP = serverIP;
  }

  set serverPort(String serverPort) {
    _serverPort = serverPort;
  }

  String get serverIP {
    return _serverIP;
  }

  String get serverPort {
    return _serverPort;
  }
*/
  Future<Map<String, KeySettings>> getAllKeys() async {
    return _keys;
  }

  Future<Map<String, KeySettings>> initAllKeys() async {
    Map<String, KeySettings> allKeys = new Map();
    allowedKeys.forEach((key) async {
      KeySettings? _ks = await getKeyFromStore(key);
      if (_ks.key != "" && _ks.key != null) {
        allKeys.putIfAbsent(_ks.name, () => _ks);
      } else {
        KeySettings _defaultKeySettings = new KeySettings("", "", "", "", "");
        switch (key) {
          case 'LIGHTS':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  Icons.lightbulb_outline_rounded, 'LIGHTS', 'L');
            }
            break;
          case 'MFD':
            {
              _defaultKeySettings =
                  new KeySettings.fromIconData(Icons.storage, 'MFD', 'INSERT');
            }
            break;
          case 'WIPERS':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  WeatherIcons.wi_storm_showers, 'WIPERS', 'w');
            }
            break;
          case 'MAP+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus, 'MAP+', 'P');
            }
            break;
          case 'MAP-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus, 'MAP-', 'k');
            }
            break;
          case 'MAP 1':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_1, 'MAP 1', 'SHIFT_NUM1');
            }
            break;
          case 'MAP 2':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'MAP 2', 'SHIFT_NUM2');
            }
            break;
          case 'MAP 3':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_3, 'MAP 3', 'SHIFT_NUM3');
            }
            break;
          case 'MAP 4':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_4, 'MAP 4', 'SHIFT_NUM4');
            }
            break;
          case 'MAP 5':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'MAP 5', 'SHIFT_NUM5');
            }
            break;
          case 'MAP 6':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'MAP 6', 'SHIFT_NUM6');
            }
            break;
          case 'MAP 7':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_7, 'MAP 7', 'SHIFT_NUM7');
            }
            break;
          case 'MAP 8':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_8, 'MAP 8', 'SHIFT_NUM8');
            }
            break;
          case 'MAP 9':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'MAP 9', 'SHIFT_NUM9');
            }
            break;
          case 'MAP 10':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_10, 'MAP 10', 'SHIFT_NUM0');
            }
            break;
          case 'TC+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus, 'TC+', 'u');
            }
            break;
          case 'TC-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus, 'TC-', 'j');
            }
            break;
          case 'TC 1':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_1, 'TC 1', 'NUMPAD1');
            }
            break;
          case 'TC 2':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'TC 2', 'NUMPAD2');
            }
            break;
          case 'TC 3':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_3, 'TC 3', 'NUMPAD3');
            }
            break;
          case 'TC 4':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_4, 'TC 4', 'NUMPAD4');
            }
            break;
          case 'TC 5':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'TC 5', 'NUMPAD5');
            }
            break;
          case 'TC 6':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'TC 6', 'NUMPAD6');
            }
            break;
          case 'TC 7':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_7, 'TC 7', 'NUMPAD7');
            }
            break;
          case 'TC 8':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_8, 'TC 8', 'NUMPAD8');
            }
            break;
          case 'TC 9':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'TC 9', 'NUMPAD9');
            }
            break;
          case 'TC 10':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_10, 'TC 10', 'NUMPAD0');
            }
            break;
          case 'TC2+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus, 'TC2+', 'r');
            }
            break;
          case 'TC2-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus, 'TC2-', 'f');
            }
            break;
          case 'ABS+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus, 'ABS+', 'y');
            }
            break;
          case 'ABS-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus, 'ABS-', 'h');
            }
            break;
          case 'ABS 1':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_1, 'ABS 1', 'SHIFT_NUMPAD1');
            }
            break;
          case 'ABS 2':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'ABS 2', 'SHIFT_NUMPAD2');
            }
            break;
          case 'ABS 3':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_3, 'ABS 3', 'SHIFT_NUMPAD3');
            }
            break;
          case 'ABS 4':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_4, 'ABS 4', 'SHIFT_NUMPAD4');
            }
            break;
          case 'ABS 5':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'ABS 5', 'SHIFT_NUMPAD5');
            }
            break;
          case 'ABS 6':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'ABS 6', 'SHIFT_NUMPAD6');
            }
            break;
          case 'ABS 7':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_7, 'ABS 7', 'SHIFT_NUMPAD7');
            }
            break;
          case 'ABS 8':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_8, 'ABS 8', 'SHIFT_NUMPAD8');
            }
            break;
          case 'ABS 9':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_2, 'ABS 9', 'SHIFT_NUMPAD9');
            }
            break;
          case 'ABS 10':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.numeric_10, 'ABS 10', 'SHIFT_NUMPAD0');
            }
            break;
          case 'BB+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus, 'BB+', 't');
            }
            break;
          case 'BB-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus, 'BB-', 'g');
            }
            break;
          case 'IGNITION':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.power, 'IGNITION', 'i');
            }
            break;
          case 'STARTER':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.car_key, 'STARTER', 's');
            }
            break;
          case 'SAVE RPLY':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.content_save, 'SAVE RPLY', 'm');
            }
            break;
        }
        allKeys.putIfAbsent(
            _defaultKeySettings.name, () => _defaultKeySettings);
      }
    });
    return allKeys;
  }

  Future<KeySettings> getKeyFromStore(String key) async {
    SharedPreferences prefs = await _prefs;
    var dbKey = prefs.getString(key);
    if (dbKey != null) {
      Map<String, dynamic> keyMap = jsonDecode(dbKey);
      KeySettings k = KeySettings.fromJson(keyMap);
      return k;
    } else {
      return new KeySettings("", "", "", "", "");
    }
  }

  Future<KeySettings> getKey(String key) async {
    return _keys.then((value) {
      return value[key]!;
    });
  }

  Future<String> getServerSetting(String key) async {
    final SharedPreferences prefs = await _prefs;
    String? _value = prefs.getString(key);
    return _value != null ? _value : "";
  }

  Future<String> getValueFromStore(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? "";
  }

  Future<void> save(String key, String value) async {
    if (key == "IP")
      serverIP = value;
    else if (key == "PORT")
      serverPort = value;
    else if (key == "TEAM")
      team = value;
    else if (key == "PASSWD")
      passwd = value;
    else if (key == "keptOn")
      keptOn = value;
    else if (key == "autosave") {
      log("autosave=" + value);
      autosave = value;
    }
    _prefs.then((store) {
      _keys.then((ks) {
        if (ks[key] != null) {
          Map<String, dynamic> mapStored = ks[key]!.toJson();
          Map<String, dynamic> newMap = jsonDecode(value);
          KeySettings storedKey = new KeySettings.fromJson(mapStored);
          KeySettings newKey = new KeySettings.fromJson(newMap);
          storedKey.key = newKey.key;
          store.setString(storedKey.name, jsonEncode(storedKey.toJson()));
          log('saving: key=$key value=$value');
        } else {
          log('inserting: key=$key value=$value');
          store.setString(key, value);
        }
      });
    });
  }
}
