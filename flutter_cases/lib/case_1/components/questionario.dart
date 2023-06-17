import 'package:flutter/material.dart';
import 'package:flutter_cases/case_1/components/questao.dart';
import 'package:flutter_cases/case_1/components/resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) responder;

  Questionario({
    required this.perguntas,
    required this.perguntaSelecionada,
    required this.responder,
  });

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada]['resposta']
            as List<Map<String, Object>>
        : [];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Questao(perguntas[perguntaSelecionada]['texto'] as String),
        ...respostas.map((resp) {
          return Resposta(
            resp['texto'].toString(),
            () => responder(resp['pontuacao'] as int),
          );
        }).toList(),
        Container()
      ],
    );
  }
}
