import 'package:bytebank/components/dialog_autenticacao_transacao.dart';
import 'package:bytebank/components/dialog_resposta.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transacao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/formulario_transacao.dart';
import 'package:bytebank/screens/lista_contatos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'eventos.dart';

void main() {

  MockContatoDao mockContatoDao;
  MockClienteTransacao mockClienteTransacao;

  setUp(() async {
    mockContatoDao = MockContatoDao();
    mockClienteTransacao = MockClienteTransacao();
  });

  testWidgets('Deve realizar uma transferência', (tester) async {

    await tester.pumpWidget(BytebankApp(
      contatoDao: mockContatoDao,
      clienteTransacao: mockClienteTransacao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final contato = Contato(0, 'Rafael', 1000);
    when(mockContatoDao.findAll()).thenAnswer((realInvocation) async {
      return [contato];
    });

    await clicarNoItemDaFuncaoDeTransferencia(tester);
    await tester.pumpAndSettle();

    final listaContato = find.byType(ListaContatos);
    expect(listaContato, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);

    final itemContato = find.byWidgetPredicate((widget) {
      if (widget is ItemContato) {
        return widget.contato.nome == 'Rafael' &&
            widget.contato.numeroConta == 1000;
      }
      return false;
    });
    expect(itemContato, findsOneWidget);

    await tester.tap(itemContato);
    await tester.pumpAndSettle();

    final formularioTransacao = find.byType(FormularioTransacao);
    expect(formularioTransacao, findsOneWidget);

    final nomeContato = find.text('Rafael');
    expect(nomeContato, findsOneWidget);

    final numeroConta = find.text('1000');
    expect(numeroConta, findsOneWidget);

    final valorTextField = find.byWidgetPredicate(
        (widget) => textFieldMatcherByLabel(widget, 'Valor'));
    expect(valorTextField, findsOneWidget);

    await tester.enterText(valorTextField, '204');

    final botaoTransferencia =
        find.widgetWithText((RaisedButton), 'Transferir');
    expect(botaoTransferencia, findsOneWidget);

    await tester.tap(botaoTransferencia);
    await tester.pumpAndSettle();

    final dialogAutenticacaoTranscao = find.byType(DialogAutenticacaoTransacao);
    expect(dialogAutenticacaoTranscao, findsOneWidget);

    final senhaTextField =
        find.byKey(dialogAutenticacaoTransacaoTextFieldSenha);
    expect(senhaTextField, findsOneWidget);

    await tester.enterText(senhaTextField, '1000');

    final botaoConfirmar = find.widgetWithText(FlatButton, 'Confirmar');
    expect(botaoConfirmar, findsOneWidget);

    when(mockClienteTransacao.save(Transacao(null, 204, contato), '1000'))
        .thenAnswer((_) async => Transacao(null, 204, contato));

    await tester.tap((botaoConfirmar));
    await tester.pumpAndSettle();

    final dialogSucesso = find.byType(SuccessDialog);
    expect(dialogSucesso, findsOneWidget);

    final botaoOk = find.widgetWithText(FlatButton, 'Ok');
    expect(botaoOk, findsOneWidget);
    await tester.tap(botaoOk);
    await tester.pumpAndSettle();

    final listaContatosFinal = find.byType(ListaContatos);
    expect(listaContatosFinal, findsOneWidget);
  });
}
