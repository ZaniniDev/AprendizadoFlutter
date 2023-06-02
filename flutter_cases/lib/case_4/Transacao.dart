// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Transacao {
  String? id;
  final String nome;
  final double valor;
  final String tipoTransacao;
  final String formatoTransferencia;
  String? descricao;
  String? categoria;
  String? conta_id;
  String? usuario_id;
  final DateTime dataTransacao;

  Transacao({
    this.id,
    required this.nome,
    required this.valor,
    required this.tipoTransacao,
    required this.formatoTransferencia,
    this.descricao,
    this.categoria,
    this.conta_id,
    this.usuario_id,
    required this.dataTransacao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'valor': valor,
      'tipoTransacao': tipoTransacao,
      'formatoTransferencia': formatoTransferencia,
      'descricao': descricao,
      'categoria': categoria,
      'conta_id': conta_id,
      'usuario_id': usuario_id,
      'dataTransacao': dataTransacao.millisecondsSinceEpoch,
    };
  }

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] as String,
      valor: map['valor'] as double,
      tipoTransacao: map['tipoTransacao'] as String,
      formatoTransferencia: map['formatoTransferencia'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      categoria: map['categoria'] != null ? map['categoria'] as String : null,
      conta_id: map['conta_id'] != null ? map['conta_id'] as String : null,
      usuario_id:
          map['usuario_id'] != null ? map['usuario_id'] as String : null,
      dataTransacao:
          DateTime.fromMillisecondsSinceEpoch((map['dataTransacao'] as int)),
    );
  }

  factory Transacao.fromRepository(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] as String,
      valor: (map['valor'] as num).toDouble(),
      tipoTransacao: map['tipoTransacao'] as String,
      formatoTransferencia: map['formatoTransferencia'] as String,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      categoria: map['categoria'] != null ? map['categoria'] as String : null,
      conta_id: map['conta_id'] != null ? map['conta_id'] as String : null,
      usuario_id:
          map['usuario_id'] != null ? map['usuario_id'] as String : null,
      dataTransacao: (map['dataTransacao'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transacao.fromJson(String source) =>
      Transacao.fromMap(json.decode(source) as Map<String, dynamic>);
}
