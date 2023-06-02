// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_cases/case_4/Conta.dart';

class ContaModel {
  String? id;
  String? descricao;
  final String nome;
  final String titular_id;

  ContaModel({
    this.id,
    required this.nome,
    required this.titular_id,
    this.descricao,
  });

  factory ContaModel.fromConta(Conta conta) {
    return ContaModel(
      id: conta.id,
      nome: conta.nome,
      descricao: conta.descricao,
      titular_id: conta.titular_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'nome': nome,
      'titular_id': titular_id,
    };
  }

  factory ContaModel.fromMap(Map<String, dynamic> map) {
    return ContaModel(
      id: map['id'] != null ? map['id'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      nome: map['nome'] as String,
      titular_id: map['titular_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContaModel.fromJson(String source) =>
      ContaModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
