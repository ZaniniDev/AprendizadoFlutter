// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Aluno {
  String? id;
  final String? nome;
  final String? curso;
  final String? turma;
  final String? celular;
  final String? ra;
  late String? senha;

  Aluno(
      {this.id,
      this.nome,
      this.curso,
      this.turma,
      this.celular,
      this.ra,
      this.senha});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'curso': curso,
      'turma': turma,
      'celular': celular,
      'ra': ra,
      'senha': senha,
    };
  }

  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'] != null ? map['id'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      curso: map['curso'] != null ? map['curso'] as String : null,
      turma: map['turma'] != null ? map['turma'] as String : null,
      celular: map['celular'] != null ? map['celular'] as String : null,
      ra: map['ra'] != null ? map['ra'] as String : null,
      senha: map['senha'] != null ? map['senha'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Aluno.fromJson(String source) =>
      Aluno.fromMap(json.decode(source) as Map<String, dynamic>);
}
