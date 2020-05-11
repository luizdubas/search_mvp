import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:service_providers/src/data/models/providers.dart';

import '../fixtures/providers_fixtures.dart';

void main() {
  group('Provider Deserialization', () {
    test('successfully deserialize a JSON', () {
      final json = jsonDecode(singleProviderJson);
      expect(Provider.fromJson(json).name, 'a+ Brigadeiro');
    });

    test('throw error on invalid json', () {
      final json = jsonDecode(invalidSingleProviderJson);
      expect(() => Provider.fromJson(json), throwsAssertionError);
    });
  });
}
