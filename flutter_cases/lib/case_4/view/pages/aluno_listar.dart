import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/utils/Status.dart';
import 'package:flutter_cases/case_4/view/components/BottomNavigationBarCase4.dart';
import 'package:flutter_cases/case_4/controllers/aluno_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PageAlunosListagem extends StatefulWidget {
  const PageAlunosListagem({Key? key}) : super(key: key);

  @override
  State<PageAlunosListagem> createState() => _PageAlunosListagemState();
}

class _PageAlunosListagemState extends State<PageAlunosListagem> {
  late AlunosController alunosController;
  final pesquisarNomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // alunosController = Provider.of<AlunosController>(context);
    // alunosController.carregarAlunos();
  }

  @override
  Widget build(BuildContext context) {
    // controllerUsuario = Provider.of<UsuariosController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Alunos'),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                // await alunosController.carregarAlunos();
                // await controller.carregarTransacoes(ContaController.conta_id);
                // mostrarFormularioPesquisar(context);
                await Provider.of<AlunosController>(context, listen: false)
                    .carregarAlunos();
                //getIt<TransacoesController>().loadTransacoesLoja(_id_loja!),
              }),
          IconButton(
            onPressed: () => context.pushNamed('case_4_aluno_adicionar'),
            icon: const Icon(Icons.add_circle_sharp),
          ),
        ],
      ),
      body: Consumer<AlunosController>(builder: (context, data, child) {
        if (data.status == Status.carregando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          color: Colors.white24,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                controller: pesquisarNomeController,
                                onChanged: (value) {
                                  setState(() {
                                    // print("Filtro ->" +
                                    //     pesquisarNomeController.text);
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Procurar...',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFDBDBDB),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(1, 0),
                            child: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: IconButton(
                                icon: Icon(
                                  Icons.search_rounded,
                                  color: Colors.green,
                                  size: 34,
                                ),
                                onPressed: () async {
                                  context.pushNamed('CreateContact');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Consumer<AlunosController>(
                  builder: (context, data, child) {
                    if (data.status == Status.carregando) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<Aluno> alunosListagem = data.alunos;
                    String textoFiltro =
                        pesquisarNomeController.text.toString().trim();
                    if (textoFiltro != "") {
                      alunosListagem = alunosListagem.where((aluno) {
                        String jsonAluno = aluno.toJson();
                        if (jsonAluno
                            .toLowerCase()
                            .trim()
                            .contains(textoFiltro.toLowerCase().trim())) {
                          return true;
                        } else {
                          return false;
                        }
                      }).toList();
                    }
                    return Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: alunosListagem.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool alunoSistemas = alunosListagem[index].curso ==
                                  "Sistema de Informação"
                              ? true
                              : false;
                          ColorSwatch<int> corCurso =
                              alunoSistemas ? Colors.green : Colors.teal;
                          String curso = alunosListagem[index].curso! ==
                                  "Sistema de Informação"
                              ? "SI"
                              : alunosListagem[index].curso! ==
                                      "Análise e Desenvolvimento de Sistemas"
                                  ? "ADS"
                                  : alunosListagem[index].curso!;
                          String semestre = alunosListagem[index].turma!;
                          String nomeAluno = alunosListagem[index].nome!;

                          return Container(
                            color: Colors.grey.withOpacity(0.05),
                            child: ListTile(
                              title: Text(nomeAluno),
                              subtitle: Wrap(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: corCurso.withOpacity(0.10),
                                      border: Border.all(
                                        color: corCurso.withOpacity(0.10),
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(150),
                                    ),
                                    child: Text(
                                      curso + " - " + semestre + "° Semestre",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ), // icon-1
                                  // icon-2
                                ],
                              ),
                              trailing: Wrap(
                                spacing: 1,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.info_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      showAlertDialogInfoAluno(
                                          context, alunosListagem[index]);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      context.pushNamed("case_4_aluno_editar",
                                          queryParameters: {
                                            'aluno':
                                                alunosListagem[index].toJson()
                                          });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_sharp,
                                      color: Colors.black,
                                    ),
                                    onPressed: () async {
                                      showAlertDialogExcluirAluno(
                                          context, alunosListagem[index]);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBarCase4(currentIndex: 0),
    );
  }
}

showAlertDialogInfoAluno(BuildContext context, Aluno aluno) {
  Widget fecharButton = TextButton(
    child: Text("Fechar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Dados - " + aluno.nome!),
    content: Text(
        "Nome: ${aluno.nome} \nRA: ${aluno.ra} \nCelular: ${aluno.celular} \nCurso: ${aluno.curso} \nTurma: ${aluno.turma}° Semestre"),
    actions: [
      fecharButton,
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

showAlertDialogExcluirAluno(BuildContext context, Aluno aluno) {
  Widget cancelarButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget confirmarButton = TextButton(
    child: Text("Confirmar"),
    onPressed: () async {
      Navigator.pop(context);
      await Provider.of<AlunosController>(context, listen: false)
          .deleterAluno(aluno);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Remover Aluno"),
    content: Text(
        "Você tem certeza que deseja remover o aluno: '" + aluno.nome! + "' ?"),
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
