

import 'package:flutter/services.dart';

Future<String?> myLoadAsset(String path) async {
  try {
    return await rootBundle.loadString(path);
  } catch(_) {
    return null;
  }
}

