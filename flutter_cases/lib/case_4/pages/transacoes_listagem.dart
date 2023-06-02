import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/Status.dart';
import 'package:flutter_cases/case_4/Transacao.dart';
import 'package:flutter_cases/case_4/components/BottomNavigationBarCase4.dart';
import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/controllers/transacoes_controller.dart';
import 'package:flutter_cases/case_4/controllers/usuarios_controller.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class TransacoesPage extends StatefulWidget {
  const TransacoesPage({Key? key}) : super(key: key);

  @override
  State<TransacoesPage> createState() => _TransacoesPageState();
}

class _TransacoesPageState extends State<TransacoesPage> {
  final _formKey = GlobalKey<FormState>();
  late TransacoesController controller;
  late UsuariosController controllerUsuario;

  TextEditingController dataInicialController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();
  TextEditingController nomeTransacaoFiltro = TextEditingController();

  final listTipoTransacao = ["Todos", "Entrada", "Saída"];
  late String tipoTransacao = listTipoTransacao[0];
  List<DropdownMenuItem<String>> _createListTipoTransacao() {
    return listTipoTransacao
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  final listFormaTransferencia = [
    "Todos",
    "Pix",
    "Dinheiro",
    "Cartão de Crédito",
    "Cartão de Débito",
    "VR/VA"
  ];
  late String formaTransferencia = listFormaTransferencia[0];
  List<DropdownMenuItem<String>> _createListFormaTransferencia() {
    return listFormaTransferencia
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  void mostrarFormularioFiltro(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Definir como true para usar o SingleChildScrollView
      builder: (BuildContext context) {
        return Container(
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: dataInicialController,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: "##/##/####")
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Data Inicial',
                        ),
                      ),
                      TextFormField(
                        controller: dataFinalController,
                        inputFormatters: [
                          MaskTextInputFormatter(mask: "##/##/####")
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Data Final',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Tipo da transação:",
                          textAlign: TextAlign.start,
                        ),
                      ),
                      DropdownButton(
                        items: _createListTipoTransacao(),
                        hint: Text("Escolha uma o tipo da transação"),
                        value: tipoTransacao,
                        onChanged: (String? value) => state(() {
                          tipoTransacao = value ?? "";
                          print("Alterou tipoTransacao!" + tipoTransacao!);
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Forma de tranferência",
                          textAlign: TextAlign.start,
                        ),
                      ),
                      DropdownButton(
                        items: _createListFormaTransferencia(),
                        hint: Text("Escolha uma forma de transferência"),
                        value: formaTransferencia,
                        onChanged: (String? value) => state(() {
                          formaTransferencia = value ?? "";
                          print("Alterou forma transf!" + formaTransferencia!);
                        }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          aplicarFiltro();
                          Navigator.pop(context);
                        },
                        child: Text('Aplicar Filtro'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void mostrarFormularioPesquisar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      builder: (BuildContext context) {
        final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
        final TextEditingController nomeTransacaoFiltro =
            TextEditingController();
        bool isKeyboardVisible = false;

        KeyboardVisibilityController keyboardVisibilityController =
            KeyboardVisibilityController();
        keyboardVisibilityController.onChange.listen((bool visible) {
          print("TECLADO ATIVADO OU DESATIVADO");
          setState(() {
            // isKeyboardVisible = visible;
          });
        });

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return Container(
            height: isKeyboardVisible
                ? MediaQuery.of(context).viewInsets.bottom + 200
                : MediaQuery.of(context).viewInsets.bottom + 150,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nomeTransacaoFiltro,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void aplicarFiltro() {
    final String dataInicial = dataInicialController.text;
    final String dataFinal = dataFinalController.text;
    final String tipoTransacaoFiltro = tipoTransacao;
    final String formaTransferenciaFiltro = formaTransferencia;
    try {
      _formKey.currentState!.save();
      if (tipoTransacao != "Todos") {
        print("Filtro tipo transacao: " + tipoTransacaoFiltro);
        // Provider.of<TransacoesController>(context, listen: false)
        //     .limparTransacoes();
        Provider.of<TransacoesController>(context, listen: false)
            .filtrarPorTipoTransacao(tipoTransacaoFiltro);
      }
    } catch (e) {}
    // Realize a lógica de filtro com os dados obtidos
    // Atualize a lista de transações com os resultados do filtro
  }

  @override
  void initState() {
    super.initState();
    if (Provider.of<TransacoesController>(context, listen: false).iniciou ==
        false) {
      Provider.of<TransacoesController>(context, listen: false)
          .carregarTransacoes(ContaController.conta_id);
      Provider.of<TransacoesController>(context, listen: false).iniciou = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<TransacoesController>(context);
    controllerUsuario = Provider.of<UsuariosController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Transações'),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                // await controller.carregarTransacoes(ContaController.conta_id);
                mostrarFormularioPesquisar(context);
                // await Provider.of<TransacoesController>(context, listen: false)
                //     .carregarTransacoes(ContaController.conta_id);
                //getIt<TransacoesController>().loadTransacoesLoja(_id_loja!),
              }),
          IconButton(
            onPressed: () => context.pushNamed('case_4_transacoes_adicionar'),
            icon: const Icon(Icons.add_circle_sharp),
          ),
          IconButton(
            onPressed: () => context.push('/case_4'),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<TransacoesController>(builder: (context, data, child) {
        return Container(
          color: Colors.white24,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Consumer<TransacoesController>(
                      builder: (context, data, child) {
                    if (data.status == Status.carregando) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    String? saldoAtual = data
                        .calcularSaldoFiltro()
                        .toStringAsFixed(2)
                        .replaceAll(".", ",");
                    return SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Saldo Atual',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                      Text("R\$" + saldoAtual,
                                          style: TextStyle(
                                              fontSize: 26,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              )),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: FloatingActionButton.large(
                              onPressed: () async {
                                // await controller.carregarTransacoes(ContaController.conta_id);
                                await Provider.of<TransacoesController>(context,
                                        listen: false)
                                    .carregarTransacoes(
                                        ContaController.conta_id);
                                //getIt<TransacoesController>().loadTransacoesLoja(_id_loja!),
                              },
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.refresh,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 8,
                child: Consumer<TransacoesController>(
                  builder: (context, data, child) {
                    if (data.status == Status.carregando) {
                      print("Status carregando!");
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.transacoesFiltro.length,
                        itemBuilder: (context, int index) {
                          double? valorTransacao =
                              data.transacoesFiltro[index].valor;
                          String? valorTransacaoReal = data
                              .transacoesFiltro[index].valor
                              .toStringAsFixed(2)
                              .replaceAll(".", ",");
                          String? dataTransacao = DateFormat('dd/MM/yyyy')
                              .format(
                                  data.transacoesFiltro[index].dataTransacao);
                          String? categoria =
                              data.transacoesFiltro[index].categoria;
                          bool entradaValor = data
                                      .transacoesFiltro[index].tipoTransacao
                                      .toLowerCase() ==
                                  "entrada"
                              ? true
                              : false;
                          Icon iconeTransacao = data.transacoesFiltro[index]
                                      .formatoTransferencia ==
                                  "Dinheiro"
                              ? Icon(
                                  Icons.money,
                                  color: Colors.green,
                                )
                              : data.transacoesFiltro[index]
                                          .formatoTransferencia ==
                                      "Pix"
                                  ? Icon(Icons.pix, color: Colors.blue)
                                  : data.transacoesFiltro[index]
                                              .formatoTransferencia ==
                                          "Cartão de Crédito"
                                      ? Icon(
                                          Icons.credit_card,
                                          color: Colors.amber,
                                        )
                                      : data.transacoesFiltro[index]
                                                  .formatoTransferencia ==
                                              "Cartão de Débito"
                                          ? Icon(Icons.credit_card,
                                              color: Colors.purple)
                                          : data.transacoesFiltro[index]
                                                      .formatoTransferencia ==
                                                  "VR/VA"
                                              ? Icon(Icons.pix,
                                                  color: Colors.orange)
                                              : Icon(
                                                  Icons.attach_money,
                                                  color: Colors.green,
                                                );
                          MaterialColor corTransacao = (entradaValor
                              ? Colors.green
                              : Colors.red) as MaterialColor;
                          return Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 15),
                            child: ListTile(
                              // contentPadding: EdgeInsets.only(top: 10),
                              //onTap: () => context.push('/transacoes/${usuarios[index].id}'),
                              title: Text(data.transacoesFiltro[index].nome),
                              subtitle: Wrap(
                                spacing: 12, // space between two icons
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  iconeTransacao,
                                  Text(
                                    dataTransacao,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ), // icon-1
                                  // icon-2
                                ],
                              ),
                              trailing: Wrap(
                                spacing: 12, // space between two icons
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: corTransacao.withOpacity(0.05),
                                        border: Border.all(
                                          color: corTransacao.withOpacity(0.04),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Text(
                                      (entradaValor ? "+" : "-") +
                                          " R\$ $valorTransacaoReal",
                                      style: TextStyle(color: corTransacao),
                                    ),
                                  ),
                                  PopupMenuButton(
                                    icon: Icon(Icons.more_vert),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: ListTile(
                                            title: Text("Editar Transação"),
                                            onTap: () {
                                              print("Editou esta transação");
                                              context.pushNamed(
                                                  "case_4_transacoes_editar",
                                                  queryParameters: {
                                                    'transacao': data
                                                        .transacoesFiltro[index]
                                                        .toJson()
                                                  });
                                            },
                                          ),
                                        ),
                                        PopupMenuItem(
                                          child: ListTile(
                                            title: Text("Remover Transação"),
                                            onTap: () {
                                              context.pop(context);
                                              showAlertDialogExcluirTransacao(
                                                  context,
                                                  data.transacoesFiltro[index]);
                                              print("Removeu esta transação");
                                            },
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                  // icon-2
                                ],
                              ),

                              onTap: () {},
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            mostrarFormularioFiltro(context);
          },
          backgroundColor: Colors.green,
          child: Container(
            child: Icon(
              Icons.filter_list,
              size: 20,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCase4(currentIndex: 0),
    );
  }
}

showAlertDialogExcluirTransacao(BuildContext context, Transacao transacao) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Confirmar"),
    onPressed: () async {
      Navigator.pop(context);
      await Provider.of<TransacoesController>(context, listen: false)
          .deleterTransacao(transacao.id!);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Remover Transação"),
    content: Text("Você tem certeza que deseja excluir a transação: '" +
        transacao.nome +
        "' ?"),
    actions: [
      cancelButton,
      continueButton,
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
