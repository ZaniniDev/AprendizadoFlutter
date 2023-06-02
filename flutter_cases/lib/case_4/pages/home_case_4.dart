import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/components/BottomNavigationBarCase4.dart';
import 'package:go_router/go_router.dart';

class Case4Home extends StatelessWidget {
  const Case4Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case 4 - Banco de Dados"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Theme(
        data: ThemeData(
          primarySwatch: Colors.green,
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Text(
                        "Aplicação com Banco de Dados",
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
                    context.pushNamed("case_4_transacoes");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search),
                      Text("Listar Transações"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed("case_4_transacoes_adicionar");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money),
                      Text("Adicionar Transações")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed("case_4_contas");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.account_balance),
                      Text("Minhas Contas")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed("case_4_contas_adicionar");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.new_label),
                      Text("Criar conta")
                    ],
                  ),
                ),
              ),
              Container()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCase4(currentIndex: 1),
    );
  }
}
