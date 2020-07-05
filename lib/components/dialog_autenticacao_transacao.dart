import 'package:flutter/material.dart';

class DialogAutenticacaoTransacao extends StatefulWidget {

  final Function(String senha) onConfirm;

  const DialogAutenticacaoTransacao({Key key, @required this.onConfirm}) : super(key: key);

  @override
  _DialogAutenticacaoTransacaoState createState() => _DialogAutenticacaoTransacaoState();
}

class _DialogAutenticacaoTransacaoState extends State<DialogAutenticacaoTransacao> {

  final TextEditingController _senhaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticar'),
      content: TextField(
        controller: _senhaController,
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 64.0,
          letterSpacing: 24.0,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_senhaController.text);
            Navigator.pop(context);
          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
