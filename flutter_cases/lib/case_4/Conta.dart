// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Conta {
  String? id;
  final String nome;
  String? descricao;
  final String titular_id;

  Conta({
    this.id,
    required this.nome,
    required this.titular_id,
    this.descricao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'titular_id': titular_id,
    };
  }

  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      titular_id: map['titular_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conta.fromJson(String source) =>
      Conta.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Conta.fromRepository(Map<String, dynamic> map) {
    return Conta(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      titular_id: map['titular_id'] as String,
    );
  }
}
