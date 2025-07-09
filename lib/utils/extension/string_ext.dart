import 'dart:convert';

import 'package:flutter/services.dart';

import '../remove_diacritic.dart';

extension StringExt on String {
  String get nameAlias {
    return removeDiacritics(this).toUpperCase();
  }
}

extension JsonLoader on String {
  Future<dynamic> loadJson() async {
    final raw = await rootBundle.loadString(this);
    return json.decode(raw);
  }
}
