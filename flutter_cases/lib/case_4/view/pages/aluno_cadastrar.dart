import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/controllers/aluno_controller.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/services/criptografiaSenha.dart';
import 'package:flutter_cases/case_4/view/components/FormAluno.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Aluno',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageCadastrarAluno(),
    );
  }
}

class PageCadastrarAluno extends StatefulWidget {
  const PageCadastrarAluno({super.key});

  @override
  State<PageCadastrarAluno> createState() => _PageCadastrarAlunoState();
}

class _PageCadastrarAlunoState extends State<PageCadastrarAluno> {
  final nomeAlunoController = TextEditingController();
  final cursoAlunoController = TextEditingController();
  final turmaAlunoController = TextEditingController();
  final celularAlunoController = TextEditingController();
  final senhaAlunoController = TextEditingController();
  final raAlunoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final alunosController = Provider.of<AlunosController>(context);

    void adicionarAluno() async {
      if (_formKey.currentState!.validate()) {
        final String senha = senhaAlunoController.text;
        final String senhaCriptografada = Criptografia.criptografarTexto(senha);

        Aluno novoAluno = Aluno(
            nome: nomeAlunoController.text,
            curso: cursoAlunoController.text,
            turma: turmaAlunoController.text,
            celular: celularAlunoController.text,
            ra: raAlunoController.text,
            senha: senhaCriptografada);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processando os dados...')),
        );
        bool sucessoCriacao = await alunosController.adicionarAluno(novoAluno);

        if (sucessoCriacao == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Aluno adicionado com sucesso!'),
              duration: Duration(seconds: 2),
            ),
          );
          nomeAlunoController.clear();
          cursoAlunoController.clear();
          turmaAlunoController.clear();
          celularAlunoController.clear();
          raAlunoController.clear();
          senhaAlunoController.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Não foi possível adicionar o Aluno!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }

    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cadastrar Aluno"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text("Cadastro de Aluno"),
              ),
              FormCadastroAluno(
                  formKey: _formKey,
                  nomeAlunoController: nomeAlunoController,
                  cursoAlunoController: cursoAlunoController,
                  turmaAlunoController: turmaAlunoController,
                  celularAlunoController: celularAlunoController,
                  raAlunoController: raAlunoController,
                  senhaAlunoController: senhaAlunoController)
            ],
          ),
        ),
        persistentFooterButtons: [
          TextButton(onPressed: adicionarAluno, child: Text("Cadastrar Aluno"))
        ],
        persistentFooterAlignment: AlignmentDirectional.center,
      ),
    );
  }
}
