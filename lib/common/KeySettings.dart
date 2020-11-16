import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

class KeySettings{
  KeySettings(this._codePoint, this._fontFamily, this._name, this._key);
  var _codePoint;
  var _fontFamily;
  var _key;
  var _name;

  get name => _name;
  set name(value) { _name = value; }

  get codePoint => _codePoint;
  set codePoint(value) {
    _codePoint = value;
  }

  get icon => _codePoint;
  set icon(String value) { _codePoint = value; }

  get key => _key;
  set key(value) {_key = value;}

  get fontFamily => _fontFamily;
  set fontFamily(value) { _fontFamily = value; }


  Map<String, dynamic> toJson() => {
    'codePoint': _codePoint,
    'fontFamily': _fontFamily,
    'key': _key,
    'name': _name,
  };

   KeySettings.fromJson(Map<String, dynamic> json) :
      _codePoint = json['codePoint'],
      _fontFamily = json['fontFamily'],
      _key = json['key'],
      _name = json['name'];
}