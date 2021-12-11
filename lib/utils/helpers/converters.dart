

import 'dart:math';
import 'dart:ui';
import 'dart:convert';


import 'package:cryptoexpo/modules/interfaces/json_serialized.dart';
import 'package:flutter/foundation.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class _DeserializeAction<T> {
  final String json;
  final T instance;
  _DeserializeAction(this.json, this.instance);

  List<T>? _invoke() {
    if(instance is JsonSerialized) {
      final _instance = instance as JsonSerialized;
    var decode = jsonDecode(json);
      if(decode is List) {

        return _instance.listFromJson(decode).cast<T>();
      }
      return _instance.listFromJson([json]).cast<T>();
    }
    return null;
  }

  static List<T>? invoke<T>
      (_DeserializeAction<T> a) => a._invoke();
}

Future<List<T>?> deserialize<T>(
    String json,
    T instance
    ) => compute(
    _DeserializeAction.invoke,
    _DeserializeAction<T>(json, instance)
);


// we use this outer function to process an object's fromJson method
// so that we can do the expensive conversion in an isolate
T? fromJson<T>(Map map) {

  JsonSerialized obj = map['obj'] as JsonSerialized;
  dynamic data = map['data'];

  var converted;

  var _json = data;

  if(data is String) {
    _json = json.decode(data);
  }

  if(_json is List) {
    converted = obj.listFromJson(_json);
  } else {
    converted = obj.fromJson(_json);
  }

  if(converted is T) return converted;

  return null;
}