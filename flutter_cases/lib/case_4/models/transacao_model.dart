// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_cases/case_4/Transacao.dart';

class TransacaoModel {
  String? id;
  String? descricao;
  String? categoria;
  final String nome;
  final double valor;
  final String tipoTransacao;
  final String formatoTransferencia;
  final String conta_id;
  final String usuario_id;
  final DateTime dataTransacao;
  final DateTime dtCreate;

  TransacaoModel({
    this.id,
    required this.nome,
    this.descricao,
    required this.valor,
    this.categoria,
    required this.tipoTransacao,
    required this.formatoTransferencia,
    required this.conta_id,
    required this.usuario_id,
    required this.dataTransacao,
    required this.dtCreate,
  });

  factory TransacaoModel.fromTransacao(Transacao transacao) {
    return TransacaoModel(
      id: transacao.id,
      nome: transacao.nome,
      descricao: transacao.descricao,
      valor: transacao.valor,
      categoria: transacao.categoria,
      tipoTransacao: transacao.tipoTransacao,
      formatoTransferencia: transacao.formatoTransferencia,
      conta_id: transacao.conta_id!,
      usuario_id: transacao.usuario_id!,
      dataTransacao: transacao.dataTransacao,
      dtCreate: transacao.dataTransacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'descricao': descricao,
      'categoria': categoria,
      'nome': nome,
      'valor': valor,
      'tipoTransacao': tipoTransacao,
      'formatoTransferencia': formatoTransferencia,
      'conta_id': conta_id,
      'usuario_id': usuario_id,
      'dataTransacao': dataTransacao,
    };
  }

  factory TransacaoModel.fromMap(Map<String, dynamic> map) {
    return TransacaoModel(
      id: map['id'] != null ? map['id'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      categoria: map['categoria'] != null ? map['categoria'] as String : null,
      nome: map['nome'] as String,
      valor: map['valor'] as double,
      tipoTransacao: map['tipoTransacao'] as String,
      formatoTransferencia: map['formatoTransferencia'] as String,
      conta_id: map['conta_id'] as String,
      usuario_id: map['usuario_id'] as String,
      dataTransacao: map['dataTransacao'] as DateTime,
      dtCreate: map['dtCreate'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransacaoModel.fromJson(String source) =>
      TransacaoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
