import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/controllers/aluno_controller.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/services/criptografiaSenha.dart';
import 'package:flutter_cases/case_4/view/components/FormAluno.dart';
import 'package:provider/provider.dart';

class PageEditarAluno extends StatefulWidget {
  final Aluno aluno;
  const PageEditarAluno({super.key, required this.aluno});

  @override
  State<PageEditarAluno> createState() => _PageEditarAlunoState();
}

class _PageEditarAlunoState extends State<PageEditarAluno> {
  late Aluno alunoEditar = widget.aluno;
  var _formKey = GlobalKey<FormState>();
  late TextEditingController nomeAlunoController;
  late TextEditingController cursoAlunoController;
  late TextEditingController turmaAlunoController;
  late TextEditingController celularAlunoController;
  late TextEditingController senhaAlunoController;
  late TextEditingController raAlunoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomeAlunoController = TextEditingController(text: alunoEditar.nome!);
    cursoAlunoController = TextEditingController(text: alunoEditar.curso!);
    turmaAlunoController = TextEditingController(text: alunoEditar.turma!);
    celularAlunoController = TextEditingController(text: alunoEditar.celular!);
    senhaAlunoController = TextEditingController(
        text: Criptografia.descriptografarTexto(alunoEditar.senha!));
    raAlunoController = TextEditingController(text: alunoEditar.ra!);
  }

  @override
  Widget build(BuildContext context) {
    final alunosController = Provider.of<AlunosController>(context);

    void editarAluno() async {
      if (_formKey.currentState!.validate()) {
        final String senha = senhaAlunoController.text;
        final String senhaCriptografada = Criptografia.criptografarTexto(senha);

        Aluno alunoAtualizado = Aluno(
            id: alunoEditar.id,
            nome: nomeAlunoController.text,
            curso: cursoAlunoController.text,
            turma: turmaAlunoController.text,
            celular: celularAlunoController.text,
            ra: raAlunoController.text,
            senha: senhaCriptografada);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processando os dados...')),
        );
        await alunosController.editarAluno(alunoAtualizado);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Informações atualizadas com sucesso!')),
        );
        nomeAlunoController.clear();
        cursoAlunoController.clear();
        turmaAlunoController.clear();
        celularAlunoController.clear();
        raAlunoController.clear();
        senhaAlunoController.clear();

        print(
            "Valores -> ${nomeAlunoController.text} / ${senhaAlunoController.text} / ${cursoAlunoController.text}");
      }
    }

    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Editar Aluno"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text("Edição de Aluno"),
              ),
              FormCadastroAluno(
                formKey: _formKey,
                nomeAlunoController: nomeAlunoController,
                cursoAlunoController: cursoAlunoController,
                turmaAlunoController: turmaAlunoController,
                celularAlunoController: celularAlunoController,
                raAlunoController: raAlunoController,
                senhaAlunoController: senhaAlunoController,
                senhaVisivel: false,
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          TextButton(onPressed: editarAluno, child: Text("Editar Aluno"))
        ],
        persistentFooterAlignment: AlignmentDirectional.center,
      ),
    );
  }
}
