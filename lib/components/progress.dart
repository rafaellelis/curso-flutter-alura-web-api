import 'package:flutter/material.dart';

class Progress extends StatelessWidget {

  final String message;

  const Progress({Key key, this.message = 'Carregando'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message, style: TextStyle(fontSize: 16.0),),
          ),
        ],
      ),
    );
  }
}