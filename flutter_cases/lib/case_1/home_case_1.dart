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
      'texto': 'Quando o flutter foi criado?',
      'resposta': [
        {'texto': '2015', 'pontuacao': 10},
        {'texto': '2017', 'pontuacao': 5},
        {'texto': '2019', 'pontuacao': 3},
        {'texto': '2021', 'pontuacao': 2},
      ],
    },
    {
      'titulo': 'Tcc Flutter - Pergunta 2',
      'texto': 'Quem desenvolveu o Flutter',
      'resposta': [
        {'texto': 'Google', 'pontuacao': 10},
        {'texto': 'Facebook', 'pontuacao': 5},
        {'texto': 'Microsoft', 'pontuacao': 3},
        {'texto': 'Apple', 'pontuacao': 2},
      ],
    },
    {
      'titulo': 'Tcc Flutter - Pergunta 3',
      'texto': 'Em qual linguagem de programação o Flutter é escrito?',
      'resposta': [
        {'texto': 'JavaScript', 'pontuacao': 10},
        {'texto': 'Swift', 'pontuacao': 5},
        {'texto': 'Kotlin', 'pontuacao': 3},
        {'texto': 'Dart', 'pontuacao': 2},
      ],
    },
    {
      'titulo': 'Tcc Flutter - Pergunta 4',
      'texto': 'Quais são os principais objetivos do flutter?',
      'resposta': [
        {
          'texto':
              'Desenvolvimento de aplicativo móveis nativos apenas para Android',
          'pontuacao': 10
        },
        {'texto': 'Desenvolvimento de aplicativo web', 'pontuacao': 5},
        {
          'texto':
              'Desenvolvimento de aplicatviso móvies nativos apenas para IOS',
          'pontuacao': 3
        },
        {
          'texto':
              'Desenvolvimento de aplicativos móveis nativos para Android e IOS ',
          'pontuacao': 2
        },
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
