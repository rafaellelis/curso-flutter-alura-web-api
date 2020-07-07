
import 'package:bytebank/models/Transacao.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('Deve retornar o valor quando criar uma transação', (){
    final transacao = Transacao(null, 200, null);
    expect(transacao.valor, 200);
  });

  test('Deve exibir erro quando criar transferência com valor menor que zero', (){
    expect(() => Transacao(null, 0, null), throwsAssertionError);
  });
}