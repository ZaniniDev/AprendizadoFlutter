import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontuacao;
  final void Function() reiniciarQuestionario;

  Resultado(this.pontuacao, this.reiniciarQuestionario);

  String get fraseResultado {
//nao pode ficar sem else.
    if (pontuacao < 8) {
      return 'Parabens ! Sua pontuação foi: ' + pontuacao.toString();
    } else if (pontuacao < 12) {
      return 'Voce é bom! Sua pontuação foi: ' + pontuacao.toString();
    } else if (pontuacao < 16) {
      return 'Impressionante! Sua pontuação foi: ' + pontuacao.toString();
    } else {
      return 'Nivel Jedi! Sua pontuação foi: ' + pontuacao.toString();
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
          child: Text('Deseja Reiniciar?'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 158, 37, 37),
              foregroundColor: Colors.white),
        )
      ],
    );
  }
}
