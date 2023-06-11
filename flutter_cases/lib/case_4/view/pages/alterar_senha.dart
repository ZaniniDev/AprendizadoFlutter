import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/controllers/aluno_controller.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/services/criptografiaSenha.dart';
import 'package:provider/provider.dart';

class PageEditarSenha extends StatefulWidget {
  const PageEditarSenha({super.key});

  @override
  State<PageEditarSenha> createState() => _PageEditarSenhaState();
}

class _PageEditarSenhaState extends State<PageEditarSenha> {
  var _formKey = GlobalKey<FormState>();
  final senhaAlunoController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final alunosController = Provider.of<AlunosController>(context);
    //caso a conta a ser alterada for a mesma que a logada
    //então pode ser alterado a senha

    void alterarSenha() async {
      if (_formKey.currentState!.validate()) {
        final String senha = confirmarSenhaController.text;
        String senhaCriptografada = Criptografia.criptografarTexto(senha);

        Aluno alunoAtualizado = alunosController.alunoLogado;
        alunoAtualizado.senha = senhaCriptografada;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processando os dados...')),
        );
        await alunosController.editarAluno(alunoAtualizado);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha atualizada com sucesso!')),
        );
        senhaAlunoController.clear();
        confirmarSenhaController.clear();
      }
    }

    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Alterar Senha"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text("Alteração de Senha"),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    TextFormField(
                      controller: senhaAlunoController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Nova Senha'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'O Senha RA é obrigatório.';
                        }
                        if (value.length < 6) {
                          return 'A senha deve possuir no mínimo 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: confirmarSenhaController,
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Confirmar Nova Senha'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'A confirmação da senha é obrigatório.';
                        }
                        if (value.length < 6) {
                          return 'A senha deve possuir no mínimo 6 caracteres.';
                        }
                        if (senhaAlunoController.text != value) {
                          return 'As senhas devem ser iguais!';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          TextButton(onPressed: alterarSenha, child: Text("Alterar Senha"))
        ],
        persistentFooterAlignment: AlignmentDirectional.center,
      ),
    );
  }
}
