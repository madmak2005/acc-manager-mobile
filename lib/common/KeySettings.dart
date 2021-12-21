
import 'package:flutter/material.dart';

class KeySettings{
  KeySettings(this._codePoint, this._fontFamily, this._fontPackage, this._name, this._key);

  factory KeySettings.fromIconData(IconData iconData, String name, String key){
    return KeySettings(iconData.codePoint, iconData.fontFamily, iconData.fontPackage, name, key);
  }

  var _codePoint;
  var _fontFamily;
  var _fontPackage;
  var _key;
  var _name;

  get name => _name;
  set name(value) { _name = value; }

  get codePoint => _codePoint;
  set codePoint(value) {
    _codePoint = value;
  }

  //get icon => _codePoint;
  set icon(String value) { _codePoint = value; }

  get key => _key;
  set key(value) {_key = value;}

  get fontFamily => _fontFamily;
  set fontFamily(value) { _fontFamily = value; }

  get fontPackage => _fontPackage;
  set fontPackage(value) { _fontPackage = value; }

  IconData toIconData(){
    return IconData(_codePoint,
        fontFamily: _fontFamily,
        fontPackage: _fontPackage
    );
  }


  Map<String, dynamic> toJson() => {
    'codePoint': _codePoint,
    'fontFamily': _fontFamily,
    'fontPackage': _fontPackage,
    'key': _key,
    'name': _name,
  };

   KeySettings.fromJson(Map<String, dynamic> json) :
      _codePoint = json['codePoint'],
      _fontFamily = json['fontFamily'],
      _fontPackage = json['fontFamily'],
      _key = json['key'],
      _name = json['name'];
}