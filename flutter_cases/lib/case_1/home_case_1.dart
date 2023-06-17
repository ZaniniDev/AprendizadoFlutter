import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCase1 extends StatelessWidget {
  const HomeCase1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case 1 - Aprendizado"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Inicie o questionário de aprendizado!",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Padding(padding: EdgeInsets.only(top: 15)),
                ElevatedButton(
                    onPressed: () {
                      context.goNamed("case_1_perguntas_respostas");
                    },
                    child: Text("Iniciar questionario")),
              ]),
        ),
      ),
    );
  }
}
