import 'package:bytebank/database/dao/cantato_dao.dart';
import 'package:bytebank/http/clients/ClienteTransacao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/dependencias_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp(
    contatoDao: ContatoDao(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContatoDao contatoDao;
  final ClienteTransacao clienteTransacao;

  BytebankApp({@required this.contatoDao, @required this.clienteTransacao});

  @override
  Widget build(BuildContext context) {
    return DependenciasApp(
      contatoDao: contatoDao,
      clienteTransacao: clienteTransacao,
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.green[900],
            accentColor: Colors.blueAccent[700],
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blueAccent[700],
              textTheme: ButtonTextTheme.primary,
            )),
        home: Dashboard(),
      ),
    );
  }
}
