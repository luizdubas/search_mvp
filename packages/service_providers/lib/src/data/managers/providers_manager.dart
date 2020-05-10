import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/providers.dart';

class ProvidersManager {
  const ProvidersManager();

  Future<List<Provider>> load() async {
    final loadedString = await rootBundle.loadString(
      'assets/providers.json',
    );
    final json = jsonDecode(loadedString) as List<dynamic>;
    final providers = json
        .map((value) => Provider.fromJson(value as Map<String, dynamic>))
        .toList();
    return providers;
  }
}
