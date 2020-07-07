import 'dart:async';

import 'package:bytebank/components/dialog_autenticacao_transacao.dart';
import 'package:bytebank/components/dialog_resposta.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/clients/ClienteTransacao.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transacao.dart';
import 'package:bytebank/widgets/dependencias_app.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FormularioTransacao extends StatefulWidget {
  final Contato contato;

  FormularioTransacao(this.contato);

  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final TextEditingController _valueController = TextEditingController();
  final String idTransacao = Uuid().v4();

  bool _sendind = false;

  @override
  Widget build(BuildContext context) {
    final dependencias = DependenciasApp.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sendind,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Enviando...',
                  ),
                ),
              ),
              Text(
                widget.contato.nome,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contato.numeroConta.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transferir'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transacao(idTransacao, value, widget.contato);

                      showDialog(
                          context: context,
                          builder: (contextDialog) =>
                              DialogAutenticacaoTransacao(
                                onConfirm: (senha) {
                                  _save(dependencias.clienteTransacao,
                                      transactionCreated, senha, context);
                                },
                              ));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    ClienteTransacao clienteTransacao,
    Transacao transactionCreated,
    String senha,
    BuildContext context,
  ) async {
    Transacao transacao =
        await _send(clienteTransacao, transactionCreated, senha, context);
    await _exibeMensagemSucesso(transacao, context);
  }

  Future _exibeMensagemSucesso(
      Transacao transacao, BuildContext context) async {
    if (transacao != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transação com sucesso');
          });
      Navigator.pop(context);
    }
  }

  Future<Transacao> _send(ClienteTransacao clienteTransacao,
      Transacao transactionCreated, String senha, BuildContext context) async {
    setState(() {
      _sendind = true;
    });
    final Transacao transacao =
        await clienteTransacao.save(transactionCreated, senha).catchError((e) {
      _exibeMensagemFalha(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _exibeMensagemFalha(context,
          message: 'Tempo de envio da requisição excedido.');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _exibeMensagemFalha(context);
    }).whenComplete(() {
      setState(() {
        _sendind = false;
      });
    });
    return transacao;
  }

  void _exibeMensagemFalha(BuildContext context,
      {String message = 'Ocorreu um erro desconhecido'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
