import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'KeySettings.dart';

final Set<String> allowedKeys = {'LIGHTS','MAP+','MAP-','MFD','TC+','TC-','ABS+','ABS-','WIPERS','BB+','BB-','IGNITION','STARTER'};

class Configuration {
  String serverIP = "";
  String serverPort = "8080";
  late Future<Map<String, KeySettings>> _keys;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<SharedPreferences> get prefs => _prefs;

  Configuration() {
    this.serverIP = "";
    this.serverPort = "8080";
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
      if (_ks.key != "") {
        allKeys.putIfAbsent(_ks.name, () => _ks);
      } else{
        KeySettings _defaultKeySettings = new KeySettings("", "", "", "", "");
        switch (key) {
          case 'LIGHTS':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  Icons.lightbulb_outline_rounded,
                  'LIGHTS',
                  'L');
            }
            break;
          case 'MFD':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  Icons.storage,
                  'MFD',
                  'INSERT');
            }
            break;
          case 'WIPERS':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  WeatherIcons.wi_storm_showers,
                  'WIPERS',
                  'w');
            }
            break;
          case 'MAP+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus,
                  'MAP+', 'P');
            }
            break;
          case 'MAP-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus,
                  'MAP-', 'k');
            }
            break;
          case 'TC+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus,
                  'TC+', 'u');
            }
            break;
          case 'TC-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus,
                  'TC-', 'j');
            }
            break;
          case 'ABS+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus,
                  'ABS+', 'y');
            }
            break;
          case 'ABS-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus,
                  'ABS-', 'h');
            }
            break;
          case 'BB+':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.plus,
                  'BB+', 't');
            }
            break;
          case 'BB-':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.minus,
                  'BB-', 'g');
            }
            break;
          case 'IGNITION':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  SimpleLineIcons.power,
                  'IGNITION', 'i');
            }
            break;
          case 'STARTER':
            {
              _defaultKeySettings = new KeySettings.fromIconData(
                  MaterialCommunityIcons.car_key,
                  'STARTER', 's');
            }
            break;
        }
        allKeys.putIfAbsent(_defaultKeySettings.name, () => _defaultKeySettings);
      }
    });
    return allKeys;
  }

  Future<KeySettings> getKeyFromStore(String key) async {
    SharedPreferences prefs = await _prefs;
    var dbKey = prefs.getString(key);
    if (dbKey != null) {
      Map<String,String> keyMap = jsonDecode(dbKey);
      return new KeySettings.fromJson(keyMap);
      }else{
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
    return  _value != null ? _value : "";
  }

  Future<void> save(String key, String value) async {
    if (key == "IP") serverIP = value;
    if (key == "PORT") serverPort = value;
    _prefs.then((store) {
      _keys.then((ks) {
        if (ks[key] != null) {
          Map<String, dynamic> mapStored = ks[key]!.toJson();
          Map<String, dynamic> newMap = jsonDecode(value);
          KeySettings storedKey = new KeySettings.fromJson(mapStored);
          KeySettings newKey = new KeySettings.fromJson(newMap);
          storedKey.key = newKey.key;
          store.setString(storedKey.name, jsonEncode(storedKey.toJson()));
          print('saving: key=$key value=$value');
        } else {
          store.setString(key, value);
        }
      });
    });
  }
}
