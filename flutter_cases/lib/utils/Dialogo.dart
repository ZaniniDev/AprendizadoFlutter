import 'package:flutter/material.dart';

mostrarDialogoSimples(BuildContext context, String titulo, String texto) {
  Widget fecharButton = TextButton(
    child: Text("Fechar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(titulo),
    content: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Center(
            child: Text(texto),
          ),
        );
      },
    ),
    actions: [
      fecharButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
