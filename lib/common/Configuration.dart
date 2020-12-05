import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:acc_manager/pages/control.page.dart';
import 'KeySettings.dart';
import 'package:flutter_icons/flutter_icons.dart';

final Set<String> allowedKeys = {'LIGHTS','MAP+','MAP-','MFD','TC+','TC-','ABS+','ABS-','WIPERS','BB+','BB-','IGNITION','STARTER'};

class Configuration {
  String _serverIP;
  String _serverPort;
  Future<Map<String, KeySettings>> _keys;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<SharedPreferences> get prefs => _prefs;

  Configuration() {
    init();
  }

  init() {
    _keys = initAllKeys();
  }

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

  Future<Map<String, KeySettings>> getAllKeys() async {
    return _keys;
  }

  Future<Map<String, KeySettings>> initAllKeys() async {
    Map<String, KeySettings> allKeys = new Map();
    allowedKeys.forEach((key) async {
      KeySettings _ks = await getKeyFromStore(key);
      if (_ks != null) {
        allKeys.putIfAbsent(_ks.name, () => _ks);
      } else{
        KeySettings _defaultKeySettings;
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
      Map keyMap = jsonDecode(dbKey);
      return new KeySettings.fromJson(keyMap);
      }
    return null;
    }




  Future<KeySettings> getKey(String key) async {
    return _keys.then((value) {
      return value[key];
    });
  }

  Future<String> getServerSetting(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<void> save(String key, String value) async {
    if (key == "IP") _serverIP = value;
    if (key == "PORT") _serverPort = value;
    _prefs.then((store) {
      _keys.then((ks) {
        if (ks[key] != null) {
          Map mapStored = ks[key].toJson();
          Map newMap = jsonDecode(value);
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
