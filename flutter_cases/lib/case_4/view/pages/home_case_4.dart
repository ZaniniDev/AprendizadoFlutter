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

    return Scaffold(
      appBar: AppBar(
        title: Text("Case 4 - Banco de Dados"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              showAlertDialogConfirmarLogout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Theme(
        data: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    IconTheme(
                      data: IconThemeData(
                        color: Colors.green,
                      ),
                      child: Icon(
                        Icons.cloud,
                      ),
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

showAlertDialogConfirmarLogout(BuildContext context) {
  // set up the buttons
  Widget cancelarButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget confirmarButton = TextButton(
    child: Text("Sim"),
    onPressed: () async {
      Navigator.pop(context);
      await Provider.of<LoginController>(context, listen: false).deslogar();
      context.pushReplacementNamed('case_4_login');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sair da conta"),
    content: Text("Você deseja sair da conta?"),
    actions: [
      cancelarButton,
      confirmarButton,
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
