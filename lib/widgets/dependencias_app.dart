import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/http/clients/ClienteTransacao.dart';
import 'package:flutter/widgets.dart';

class DependenciasApp extends InheritedWidget {
  final ContatoDao contatoDao;
  final ClienteTransacao clienteTransacao;

  DependenciasApp(
      {@required this.contatoDao,
      @required this.clienteTransacao,
      @required Widget child})
      : super(child: child);

  static DependenciasApp of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DependenciasApp>();

  @override
  bool updateShouldNotify(DependenciasApp oldWidget) {
    return contatoDao != oldWidget.contatoDao ||
        clienteTransacao != oldWidget.clienteTransacao;
  }
}
