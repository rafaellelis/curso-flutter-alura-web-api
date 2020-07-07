import 'package:bytebank/main.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/formulario_contato.dart';
import 'package:bytebank/screens/lista_contatos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'eventos.dart';

void main() {
  testWidgets('deve salvar um contato', (tester) async {
    final mockContatoDao = MockContatoDao();

    await tester.pumpWidget(BytebankApp(contatoDao: mockContatoDao,));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clicarNoItemDaFuncaoDeTransferencia(tester);

    await tester.pumpAndSettle();

    final listaContato = find.byType(ListaContatos);
    expect(listaContato, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);

    final fabNovoContato = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNovoContato, findsOneWidget);

    await tester.tap(fabNovoContato);
    await tester.pumpAndSettle();

    final formularioContato = find.byType(FormularioContato);
    expect(formularioContato, findsOneWidget);

    final nomeTextField = find.byWidgetPredicate((widget) => textFieldMatcherByLabel(widget, 'Nome completo'));
    expect(nomeTextField, findsOneWidget);

    await tester.enterText(nomeTextField, 'Rafael Teste');

    final numeroContaTextField = find.byWidgetPredicate((widget) => textFieldMatcherByLabel(widget, 'Número da conta'));
    expect(numeroContaTextField, findsOneWidget);

    await tester.enterText(numeroContaTextField, '9999');

    final botaoCriar = find.widgetWithText(RaisedButton, 'Criar');
    expect(botaoCriar, findsOneWidget);
    await tester.tap(botaoCriar);

    verify(mockContatoDao.save(Contato(0,'Rafael Teste', 9999))).called(1);

    await tester.pumpAndSettle();

    final listaContatoAposCadastro = find.byType(ListaContatos);
    expect(listaContatoAposCadastro, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);
  });
}
