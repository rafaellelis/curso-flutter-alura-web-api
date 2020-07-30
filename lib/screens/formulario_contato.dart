import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/widgets/dependencias_app.dart';
import 'package:flutter/material.dart';

class FormularioContato extends StatefulWidget {
  @override
  _FormularioContatoState createState() => _FormularioContatoState();
}

class _FormularioContatoState extends State<FormularioContato> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependencias = DependenciasApp.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome completo'),
              style: TextStyle(fontSize: 24.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _numeroContaController,
                decoration: InputDecoration(labelText: 'Número da conta'),
                style: TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Criar'),
                  onPressed: () {
                    final String nome = _nomeController.text;
                    final int conta = int.tryParse(_numeroContaController.text);
                    final Contato novoContato = Contato(0, nome, conta);
                    _save(dependencias.contatoDao, novoContato, context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save(ContatoDao contatoDao, Contato novoContato, BuildContext context) async{
    await contatoDao.save(novoContato);
    Navigator.pop(context);
  }
}
