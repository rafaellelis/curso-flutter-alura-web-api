import 'package:bytebank/screens/lista_contatos.dart';
import 'package:bytebank/screens/lista_transacoes.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                _FeatureItem(
                  'Transferência',
                  Icons.monetization_on,
                  onClick: () => _exibeListaContatos(context),
                ),
                _FeatureItem(
                  'Lista Transações',
                  Icons.description,
                  onClick: () => _exibeListaTrasacoes(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Function onClick;

  _FeatureItem(
    this.titulo,
    this.icone, {
    @required this.onClick,
  })  : assert(icone != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            height: 100,
            width: 150,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icone,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  titulo,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _exibeListaContatos(BuildContext context) {
  Navigator.of(context).push(
    (MaterialPageRoute(
      builder: (context) => ListaContatos(),
    )),
  );
}

void _exibeListaTrasacoes(BuildContext context) {
  Navigator.of(context).push(
    (MaterialPageRoute(
      builder: (context) => ListaTransacoes(),
    )),
  );
}
