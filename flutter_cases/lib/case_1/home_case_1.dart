import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

// container  = espaçamento entre os conteudos
// margem - distancia o conteudo dos elementos
// border = borda
////Padding = espaçamento dentro do container , nao deixar o conteudo gruadado
///child = conteudo

class PerguntasApp extends StatefulWidget {
  const PerguntasApp({super.key});

  @override

//Scaffold - componente relacionado a estrutra
//Stateless widget - utilizando para tela final.
  @override
  State<PerguntasApp> createState() => _PerguntaAppState();
}

class _PerguntaAppState extends State<PerguntasApp> {
  var perguntaSelecionada = 0;
  var pontuacaoTotal = 0;
  final perguntas = const [
    {
      'titulo': 'Tcc Flutter - Pergunta 1',
      'texto': 'Qual é a sua cor favorita?',
      'resposta': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'amarelo', 'pontuacao': 5},
        {'texto': 'azul', 'pontuacao': 3},
        {'texto': 'roxo', 'pontuacao': 2},
      ],
    },
    {
      'titulo': 'Tcc Flutter - Pergunta 2',
      'texto': 'Qual é a sua comida?',
      'resposta': [
        {'texto': 'Arroz', 'pontuacao': 10},
        {'texto': 'Strogonof', 'pontuacao': 5},
        {'texto': 'Macarrao', 'pontuacao': 3},
        {'texto': 'Almondega', 'pontuacao': 2},
      ],
    },
    {
      'titulo': 'Tcc Flutter - Pergunta 3',
      'texto': 'Qual seu estilo de musica?',
      'resposta': [
        {'texto': 'Hip-Hop', 'pontuacao': 10},
        {'texto': 'Rock', 'pontuacao': 5},
        {'texto': 'Pop', 'pontuacao': 3},
        {'texto': 'Pagode', 'pontuacao': 2},
      ],
    },
    {
      'titulo': 'Tcc Flutter - Pergunta 4',
      'texto': 'Qual é a sua fruta?',
      'resposta': [
        {'texto': 'Maça', 'pontuacao': 10},
        {'texto': 'Pera', 'pontuacao': 5},
        {'texto': 'Banana', 'pontuacao': 3},
        {'texto': 'Coco', 'pontuacao': 2},
      ],
    },
    {
      'titulo': 'Resultado',
    }
  ];

  void responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        perguntaSelecionada++;
        pontuacaoTotal += pontuacao;
      });
    }
  }

  void reiniciarQuestionario() {
    setState(() {
      perguntaSelecionada = 0;
      pontuacaoTotal = 0;
    });
  }

//sera utilizado para nao acessar pergunta invalida
  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(perguntas[perguntaSelecionada]['titulo'] as String),
          backgroundColor: Colors.lightBlue,
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntas: perguntas,
                perguntaSelecionada: perguntaSelecionada,
                responder: responder,
              )
            : Resultado(pontuacaoTotal, reiniciarQuestionario));
  }
}
