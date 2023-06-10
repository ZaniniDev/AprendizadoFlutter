import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/controllers/aluno_controller.dart';
import 'package:flutter_cases/case_4/view/components/BottomNavigationBarCase4.dart';
import 'package:flutter_cases/case_4/controllers/login_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PageHomeAlunos extends StatelessWidget {
  const PageHomeAlunos({super.key});

  @override
  Widget build(BuildContext context) {
    final alunosController = Provider.of<AlunosController>(context);
    final loginController = Provider.of<LoginController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Case 4 - Banco de Dados"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              loginController.deslogar();
              context.pushReplacementNamed('case_4_login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Theme(
        data: ThemeData(
          primarySwatch: Colors.green,
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Theme(
                  data: ThemeData(
                      primarySwatch: Colors.green,
                      iconTheme: IconThemeData(color: Colors.green)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.cloud,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Text(
                        "CRUD de Alunos",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed("case_4_aluno_listar");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school),
                      Text("Listar Alunos"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed("case_4_aluno_adicionar");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add), Text("Adicionar Aluno")],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    //envia o aluno logado para editar
                    context.pushNamed("case_4_aluno_editar", queryParameters: {
                      'aluno': alunosController.alunoLogado.toJson()
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.person), Text("Minha Conta")],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed("case_4_aluno_editarsenha");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.key), Text("Alterar Senha")],
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCase4(currentIndex: 1),
    );
  }
}
