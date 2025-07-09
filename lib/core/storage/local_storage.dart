// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

abstract class ILocalStorage {
  Future<void> init();
  bool get isFirstLaunch;
  String get fcmToken;
  void saveFcmToken(String value);
}

@singleton
class LocalStorage extends ILocalStorage {
  static final LocalStorage _singleton = LocalStorage._internal();
  factory LocalStorage() {
    return _singleton;
  }
  LocalStorage._internal();

  static const String KEY_FIRST_LAUNCH = "KEY_FIRST_LAUNCH";
  static const String KEY_FCM_TOKEN = "KEY_FCM_TOKEN";

  late Box _box;

  @override
  Future<void> init() async {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        Hive.init((await getApplicationDocumentsDirectory()).path);
      }
    }
    _box = await Hive.openBox("box");
  }

  @override
  bool get isFirstLaunch {
    final value = _box.get(KEY_FIRST_LAUNCH, defaultValue: true);
    if (value) {
      _box.put(KEY_FIRST_LAUNCH, false);
    }
    return value;
  }

  @override
  String get fcmToken => _box.get(KEY_FCM_TOKEN, defaultValue: "");

  @override
  void saveFcmToken(String value) {
    _box.put(KEY_FCM_TOKEN, value);
  }
}
