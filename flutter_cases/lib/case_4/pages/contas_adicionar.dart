import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/Conta.dart';
import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/controllers/usuarios_controller.dart';
import 'package:provider/provider.dart';

class PaginaAdicionarConta extends StatefulWidget {
  const PaginaAdicionarConta({super.key});

  @override
  State<PaginaAdicionarConta> createState() => _PaginaAdicionarContaState();
}

class _PaginaAdicionarContaState extends State<PaginaAdicionarConta> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _nomeContaController;
  final TextEditingController _descricaoContaController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _nomeContaController = TextEditingController(text: "Nova Conta");
  }

  void adicionarConta() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processando os dados...')),
      );
      String idUsuario = UsuariosController.id;
      Conta novaConta = Conta(
          nome: _nomeContaController.text,
          descricao: _descricaoContaController.text,
          titular_id: idUsuario);
      ContasUsuarioController controller =
          Provider.of<ContasUsuarioController>(context, listen: false);
      await controller.adicionarConta(novaConta);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta Criada!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Criar Conta"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ContaFormulario(
                formKey: formKey,
                nomeContaController: _nomeContaController,
                descricaoContaController: _descricaoContaController,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Theme(
              data: ThemeData(
                primarySwatch: Colors.green,
              ),
              child: ElevatedButton.icon(
                icon: Icon(Icons.new_label),
                label: Text('Criar Conta'),
                onPressed: adicionarConta,
              )),
        ),
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nomeContaController,
              decoration: InputDecoration(labelText: 'Nome *'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, informe o nome da conta.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descricaoContaController,
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
