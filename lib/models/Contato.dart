class Contato {
  final int id;
  final String nome;
  final int numeroConta;

  Contato.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['name'],
        numeroConta = json['accountNumber'];

  @override
  String toString() {
    return 'Contato{id: $id, nome: $nome, numeroConta: $numeroConta}';
  }

  Contato(this.id, this.nome, this.numeroConta);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': nome,
        'accountNumber': numeroConta,
      };
}
