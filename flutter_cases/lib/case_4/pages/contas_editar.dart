import 'package:flutter/material.dart';

class PaginaEditarConta extends StatefulWidget {
  const PaginaEditarConta({super.key});

  @override
  State<PaginaEditarConta> createState() => _PaginaEditarContaState();
}

class _PaginaEditarContaState extends State<PaginaEditarConta> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nomeContaController =
        TextEditingController(text: "Adicionar Controller");
    final TextEditingController descricaoContaController =
        TextEditingController();
    return Scaffold(
      body: ContaFormulario(
        formKey: formKey,
        nomeContaController: nomeContaController,
        descricaoContaController: descricaoContaController,
      ),
    );
  }
}

class ContaFormulario extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeContaController;
  final TextEditingController descricaoContaController;

  ContaFormulario({
    Key? key,
    required this.formKey,
    required this.nomeContaController,
    required this.descricaoContaController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nomeContaController,
              initialValue: nomeContaController.text,
              decoration: InputDecoration(
                  labelText: 'Nome', suffixText: '*', focusColor: Colors.red),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, informe o nome da conta.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descricaoContaController,
              initialValue: descricaoContaController.text,
              decoration: InputDecoration(labelText: 'Descricao'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, informe a descrição da conta.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
