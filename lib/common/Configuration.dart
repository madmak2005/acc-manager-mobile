import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:virtual_keyboard/pages/graphics.page.dart';
import 'KeySettings.dart';


final Set<String> allowedKeys = {'LIGHTS','MAP+','MAP-'};

class Configuration {
  String _serverIP;
  String _serverPort;
  Future<Map<String, KeySettings>> _keys;

//  get keys => _keys;
// set keys(value) {
//    _keys = value;
//  }

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
              _defaultKeySettings = new KeySettings(
                  Icons.lightbulb_outline_rounded.codePoint,
                  'MaterialIcons',
                  'LIGHTS',
                  'L');
            }
            break;
          case 'MAP+':
            {
              _defaultKeySettings = new KeySettings(Icons.arrow_circle_up.codePoint,
                  'MaterialIcons', 'MAP+', 'P');
            }
            break;
          case 'MAP-':
            {
              _defaultKeySettings = new KeySettings(Icons.arrow_circle_down.codePoint,
                  'MaterialIcons', 'MAP-', 'k');
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
    log('GET KEY $key');
    return _keys.then((value) {
      log('RETURN: ${value[key].key}');
      return value[key];
    });
    //return null;
    //SharedPreferences prefs = await _prefs;
    /*
    if (keys.containsKey(key)) {
      var dbKey = prefs.getString(key);
      if (dbKey != null) {
        log(dbKey);
        Map keyMap = jsonDecode(dbKey);
        KeySettings keySettings = new KeySettings.fromJson(keyMap);
        keys.putIfAbsent(
            keySettings.name, () => jsonEncode(keySettings.toJson()));
        keys[keySettings.name] = jsonEncode(keySettings.toJson());
      }
    }
    */

/*
    if (key == 'LIGHTS') {
      bool _hasLights = false;
      var lights = prefs.getString('LIGHTS');
      if (lights != null) {
        Map lightsMap = jsonDecode(lights);
        KeySettings keyLight = new KeySettings.fromJson(lightsMap);
        keys.putIfAbsent(keyLight.name, () => jsonEncode(keyLight.toJson()));
        keys[keyLight.name] = jsonEncode(keyLight.toJson());
        _hasLights = true;
      };
*/
/*
      if (!_hasKey) {
        log("No key: $key");

        _prefs.then((SharedPreferences s) {
          var json = jsonEncode(keySettings.toJson());
          log(json);
          s.setString(keySettings.name, json);
          keys.putIfAbsent(keySettings.name, () => keySetting);
          save(keySettings.name, json);
        });
      }
*/
    /*
      String keyString = keys[key];
     */
      //return new KeySettings.fromJson(jsonDecode(keyString));
    //return null;
  }

  Future<String> getServerSetting(String key) async {
    final SharedPreferences prefs = await _prefs;
    log('prefs: ${prefs.getString(key)}');
    return prefs.getString(key);
  }

  Future<void> save(String key, String value) async {
    if (key == "IP") _serverIP = value;
    if (key == "PORT") _serverPort = value;
    log('value: $value');
    _prefs.then((store) {
      _keys.then((ks) {
        if (ks[key] != null) {
          Map mapStored = ks[key].toJson();
          Map newMap = jsonDecode(value);
          KeySettings storedKey = new KeySettings.fromJson(mapStored);
          KeySettings newKey = new KeySettings.fromJson(newMap);
          log('SAVING $key');
          storedKey.key = newKey.key;
          store.setString(storedKey.name, jsonEncode(storedKey.toJson()));
          print('saving: key=$key value=$value');
        } else {
          log('SAVING $key');
          store.setString(key, value);
        }
      });

    });
  }
}
