import 'package:flutter/material.dart';

class DropDownCursos extends StatelessWidget {
  final listCursos = [
    "Sistema de Informação",
    "Análise e Desenvolvimento de Sistemas"
  ];
  final String? cursoEscolhido;
  final ValueChanged<String?> onChanged;

  DropDownCursos({
    Key? key,
    this.cursoEscolhido,
    required this.onChanged,
  }) : super(key: key);

  List<DropdownMenuItem<String>> _createListCursos() {
    return listCursos
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: _createListCursos(),
      value: cursoEscolhido != "" && cursoEscolhido != null
          ? cursoEscolhido
          : null,
      hint: Text("Curso"),
      validator: (value) =>
          value == null ? 'O campo Curso é obrigatório' : null,
      onChanged: onChanged,
    );
  }
}
