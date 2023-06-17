import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() reiniciarQuestionario;

  Resultado(this.pontuacao, this.reiniciarQuestionario);

  String get fraseResultado {
//nao pode ficar sem else.
    if (pontuacao < 8) {
      return 'Você pode melhorar! Sua pontuação foi: ' + pontuacao.toString();
    } else if (pontuacao < 12) {
      return 'Você é bom! Sua pontuação foi: ' + pontuacao.toString();
    } else if (pontuacao < 16) {
      return 'Você está com o aprendizado em dia! Sua pontuação foi: ' +
          pontuacao.toString();
    } else {
      return 'Você sabe muito! Sua pontuação foi: ' + pontuacao.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            fraseResultado,
            style: TextStyle(fontSize: 20),
          ),
        ),
        ElevatedButton(
          onPressed: reiniciarQuestionario,
          child: Text('Reiniciar Questionário'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.white),
        )
      ],
    );
  }
}
