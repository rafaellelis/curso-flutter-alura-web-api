import 'package:bytebank/database/dao/cantato_dao.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:flutter/material.dart';

class FormularioContato extends StatefulWidget {
  @override
  _FormularioContatoState createState() => _FormularioContatoState();
}

class _FormularioContatoState extends State<FormularioContato> {
  final TextEditingController _nomeController = TextEditingController();

  final TextEditingController _numeroContaController = TextEditingController();
  final ContatoDao _contatoDao = ContatoDao();

  @override
  Widget build(BuildContext context) {
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
                    _contatoDao.save(novoContato).then(
                      (id) => Navigator.pop(context),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
