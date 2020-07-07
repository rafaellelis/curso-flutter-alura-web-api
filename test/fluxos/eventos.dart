
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> clicarNoItemDaFuncaoDeTransferencia(WidgetTester tester) {
  final transferenciaFeatureItem = find.byWidgetPredicate((widget) =>
      featureItemMatcher(widget, 'Transferência', Icons.monetization_on));
  expect(transferenciaFeatureItem, findsOneWidget);
  return tester.tap(transferenciaFeatureItem);
}