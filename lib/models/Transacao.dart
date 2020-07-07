import 'Contato.dart';

class Transacao {
  final String id;
  final double valor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transacao &&
          runtimeType == other.runtimeType &&
          valor == other.valor &&
          contato == other.contato;

  @override
  int get hashCode => valor.hashCode ^ contato.hashCode;
  final Contato contato;

  Transacao(
      this.id,
      this.valor,
      this.contato,
      ) : assert(valor > 0);

  Transacao.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      valor = json['value'],
      contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() =>
      {
        'id' : id,
        'value': valor,
        'contact': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transacao{id: $id, valor: $valor, contato: $contato}';
  }

}