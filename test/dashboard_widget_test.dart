import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('deve exibir a imagem principal quando o Dashboard for aberto',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
  testWidgets(
      'deve exibir a funcionalidade de transferência quando o Dashboard for aberto',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final transferenciaFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transferência', Icons.monetization_on));
    expect(transferenciaFeatureItem, findsOneWidget);
  });
  testWidgets(
      'deve exibir a funcionalidade de lista de transações quando o Dashboard for aberto',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final listaTransacoesFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Lista Transações', Icons.description));
    expect(listaTransacoesFeatureItem, findsOneWidget);
  });
}

bool featureItemMatcher(Widget widget, String titulo, IconData icone) {
  if (widget is FeatureItem) {
    return widget.titulo == titulo && widget.icone == icone;
  }
  return false;
}
