import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/Conta.dart';
import 'package:flutter_cases/case_4/components/BottomNavigationBarCase4.dart';
import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/Status.dart';
import 'package:flutter_cases/case_4/controllers/usuarios_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ContaTransferencia {
  String? id;
  final String nome;
  String? descricao;

  ContaTransferencia({
    this.id,
    required this.nome,
    this.descricao,
  });
}

class MinhasContasPage extends StatefulWidget {
  const MinhasContasPage({super.key});

  @override
  State<MinhasContasPage> createState() => _MinhasContasPageState();
}

class _MinhasContasPageState extends State<MinhasContasPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ContasUsuarioController>(context, listen: false)
        .carregarContas(UsuariosController.id);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contas"),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<ContasUsuarioController>(context, listen: false)
                      .carregarContas(UsuariosController.id);
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Escolha sua conta",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Consumer<ContasUsuarioController>(
                    builder: (context, data, child) {
                  if (data.status == Status.carregando) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<Conta> contas = data.contas;
                  return Wrap(
                    children: contas.length > 0
                        ? List.generate(
                            contas.length,
                            (index) => Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  // contentPadding: EdgeInsets.only(top: 10),
                                  //onTap: () => context.push('/transacoes/${usuarios[index].id}'),
                                  title: Text(contas[index].nome),
                                  subtitle: Text(contas[index].descricao!),

                                  trailing: Wrap(
                                    spacing: 12, // space between two icons
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: <Widget>[
                                      PopupMenuButton(
                                        icon: Icon(Icons.more_vert),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              child: ListTile(
                                                title: Text("Editar Conta"),
                                                onTap: () {
                                                  // print("Editou esta transação");
                                                  // context.pushNamed(
                                                  //     "case_4_transacoes_editar",
                                                  //     queryParameters: {
                                                  //       'transacao': data
                                                  //           .transacoesFiltro[index]
                                                  //           .toJson()
                                                  //     });
                                                },
                                              ),
                                            ),
                                            PopupMenuItem(
                                              child: ListTile(
                                                title:
                                                    Text("Remover Transação"),
                                                onTap: () {
                                                  // context.pop(context);
                                                  // showAlertDialogExcluirTransacao(
                                                  //     context,
                                                  //     data.transacoesFiltro[index]);
                                                  // print("Removeu esta transação");
                                                },
                                              ),
                                            ),
                                          ];
                                        },
                                      ),
                                      // icon-2
                                    ],
                                  ),

                                  onTap: () {
                                    ContaController.conta_id =
                                        contas[index].id!;
                                    if (context.canPop() == true) {
                                      context.pop();
                                    }
                                    context.pushReplacementNamed("case_4_home");
                                  },
                                ),
                              ),
                            ),
                          )
                        : [
                            Padding(padding: EdgeInsets.only(top: 15)),
                            Center(
                              child: FloatingActionButton(
                                  onPressed: () {
                                    context.goNamed("case_4_contas_adicionar");
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Icon(Icons.add)],
                                  )),
                            ),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       context.pushReplacementNamed(
                            //           "case_4_contas_adicionar");
                            //     },
                            //     child: Row(
                            //       children: [
                            //         Icon(Icons.add_circle_sharp),
                            //         Text("Adicionar conta"),
                            //       ],
                            //     ))
                          ],
                  );
                }),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBarCase4(currentIndex: 2),
      ),
    );
  }
}
