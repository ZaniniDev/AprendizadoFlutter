import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/controllers/aluno_controller.dart';
import 'package:flutter_cases/case_4/controllers/login_controller.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/utils/Status.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PageLoginAluno extends StatefulWidget {
  const PageLoginAluno({super.key});

  @override
  State<PageLoginAluno> createState() => _PageLoginAlunoState();
}

class _PageLoginAlunoState extends State<PageLoginAluno> {
  final _formKey = GlobalKey<FormState>();
  final senhaAlunoController = TextEditingController();
  final raAlunoController = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    final alunosController = Provider.of<AlunosController>(context);

    void loginUsuario() async {
      if (_formKey.currentState!.validate()) {
        final String senha = senhaAlunoController.text;
        final String ra = raAlunoController.text;
        Aluno alunoLogado = await loginController.logarAluno(ra, senha);
        bool alunoAutenticado = loginController.autenticado;

        if (alunoAutenticado) {
          alunosController.alunoLogado = alunoLogado;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario Logado!'),
              duration: Duration(seconds: 2),
            ),
          );
          await Future.delayed(Duration(seconds: 3));

          context.pushReplacementNamed("case_4_home");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('RA ou senha incorreta!')),
          );
        }
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Consumer<LoginController>(builder: (context, data, child) {
          if (data.status == Status.carregando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  child: Icon(
                    Icons.person,
                  ),
                ),
                TextFormField(
                  controller: raAlunoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'RA'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'RA é obrigatório.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: senhaAlunoController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Senha é obrigatório.';
                    }
                    return null;
                  },
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed("case_4_aluno_adicionar");
                    },
                    child: Text("Criar Conta")),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: ElevatedButton(
                      onPressed: loginUsuario,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Entrar",
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     ContaController.conta_id = "PgZAuynDWughUPYbuqIH";
                //     UsuariosController.usuario = "tccgrupo";
                //     UsuariosController.senha = "tcc2023";
                //     bool autenticado = await UsuariosController.auth();
                //     if (autenticado) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('Usuario Logado!')),
                //       );
                //       ContaController.conta_id = "PgZAuynDWughUPYbuqIH";
                //       await Future.delayed(Duration(seconds: 3));
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('Usuario Test Logado!')),
                //       );
                //     }
                //     context.pop();
                //     context.pushReplacementNamed("case_4_contas");
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "Entrar sem usuario",
                //         textAlign: TextAlign.center,
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
