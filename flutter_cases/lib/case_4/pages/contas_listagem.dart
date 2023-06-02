import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/components/BottomNavigationBarCase4.dart';
import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/controllers/transacoes_controller.dart';
import 'package:flutter_cases/case_4/Status.dart';
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
  List<ContaTransferencia> contas = [
    new ContaTransferencia(
        nome: "DASA",
        descricao: "Conta referente as transações do diretório academico",
        id: "PgZAuynDWughUPYbuqIH"),
    new ContaTransferencia(
        nome: "Conta Pessoal",
        descricao: "Conta referente as transações pessoais",
        id: "UwjAIVkWwv93raUXIFtM")
  ];
  late ContasUsuarioController controllerContas;

  Widget build(BuildContext context) {
    controllerContas = Provider.of<ContasUsuarioController>(context);

    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contas"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        ),
        body: Container(
          child: Column(
            children: [
              Align(
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
              Align(
                alignment: Alignment.centerLeft,
                child: Consumer<ContasUsuarioController>(
                    builder: (context, data, child) {
                  if (data.status == Status.carregando) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Wrap(
                    children: contas.length > 0
                        ? List.generate(
                            contas.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Lógica a ser executada quando o botão for pressionado
                                  ContaController.conta_id = contas[index].id!;
                                  context.pushReplacementNamed("case_4_home");
                                  Provider.of<TransacoesController>(context,
                                          listen: false)
                                      .limparTransacoes();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          contas[index].nome,
                                        ),
                                        Text(
                                          contas[index].descricao != null
                                              ? contas[index].descricao!
                                              : "",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : [
                            ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Icon(Icons.add_circle_sharp),
                                    Text("Adicionar conta"),
                                  ],
                                ))
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
