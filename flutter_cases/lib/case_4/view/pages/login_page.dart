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
  late LoginController loginController;
  late AlunosController alunosController;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    alunosController = Provider.of<AlunosController>(context);
    loginController = Provider.of<LoginController>(context);

    void loginUsuario() async {
      if (_formKey.currentState!.validate()) {
        final String senha = senhaAlunoController.text;
        final String ra = raAlunoController.text;
        Aluno alunoLogado = await loginController.logarAluno(ra, senha);
        bool alunoAutenticado = loginController.autenticado;
        if (alunoAutenticado) {
          alunosController.alunoLogado = alunoLogado;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Bem vindo " + alunoLogado.nome! + "!"),
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(Duration(seconds: 5)).then((value) {
            context.pushReplacementNamed("case_4_home");
          });
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
        child: Theme(
          data: ThemeData(
            primarySwatch: Colors.green,
          ),
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
                    maxLength: 6,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o RA.';
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
                        return 'Digite a senha.';
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
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
