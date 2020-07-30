import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/Transacao.dart';
import 'package:bytebank/widgets/dependencias_app.dart';
import 'package:flutter/material.dart';

class ListaTransacoes extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final dependencias = DependenciasApp.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Transações'),
        ),
        body: FutureBuilder<List<Transacao>>(
          future: dependencias.clienteTransacao.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transacao> transacoes = snapshot.data;
                  if (transacoes.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final Transacao transacao = transacoes[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transacao.valor.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transacao.contato.numeroConta.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transacoes.length,
                    );
                  }
                }

                return CenteredMessage(
                  'Nenhuma transação encontrada',
                  icon: Icons.warning,
                );

                break;
            }

            return CenteredMessage('Ocorreu um erro inesperado');
          },
        ));
  }
}
