import 'dart:convert';

import 'package:bytebank/models/Transacao.dart';
import 'package:http/http.dart';

import '../client.dart';

class ClienteTransacao {
  Future<List<Transacao>> findAll() async {
    final Response response = await client.get(baseUrl);

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Transacao.fromJson(json)).toList();
  }

  Future<Transacao> save(Transacao transacao, String senha) async {
    final String transactionJson = jsonEncode(transacao.toJson());

    final Response response = await client
        .post(baseUrl,
            headers: {
              'Content-type': 'application/json',
              'password': senha,
            },
            body: transactionJson)
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return Transacao.fromJson(jsonDecode(response.body));
    }

    throw (HttpException(_getMessage(response.statusCode)));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Erro desconhecido';
  }

  static const Map<int, String> _statusCodeResponses = {
    400: 'ocorreu um erro ao enviar a transação',
    401: 'falha na autenticação',
    409: 'transação já existe'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
