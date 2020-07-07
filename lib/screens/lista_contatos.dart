import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/screens/formulario_contato.dart';
import 'package:bytebank/screens/formulario_transacao.dart';
import 'package:bytebank/widgets/dependencias_app.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {

  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {

  @override
  Widget build(BuildContext context) {
    final dependencias = DependenciasApp.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: List(),
        future: dependencias.contatoDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contato contato = contatos[index];
                  return ItemContato(
                    contato,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => FormularioTransacao(contato)),
                      );
                    },
                  );
                },
                itemCount: contatos.length,
              );
              break;
          }
          return Text('Ocorreu um erro inesperado');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => FormularioContato(),
                ),
              )
              .then((value) => {setState(() {})});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemContato extends StatelessWidget {
  final Contato contato;
  final Function onClick;

  ItemContato(
    this.contato, {
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contato.nome,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contato.numeroConta.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
