import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: PaginaInicial(),
    debugShowCheckedModeBanner: false,
  ));
}

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    String descPrimeiroCase =
        "O primeiro case retrata como aprendemos a utilizar os recursos básicos do Flutter";
    return Scaffold(
      //appbar = topo da pagina, como se fosse um header
      appBar: AppBar(
        //title = é o titulo do appbar
        title: Text('TCC Flutter'),
        //actions = parte superior direito do appbar
        actions: <Widget>[
          //iconbutton = widget que tem como parametros o icone e o onpressed
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.import_contacts),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.qr_code_2),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_box),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.attach_money),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Titulo Home Flutter Cases"),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 10),
              child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.lightGreen,
                    brightness: Brightness.light,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.amber[50]),
                        onPressed: () {
                          print("Pressionado botao 1 case!");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.quiz),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text("Primeiro Case"),
                            )
                          ],
                        ),
                      ),

                      //colocamos o text para descrevermos como será o case 1,2..
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          descPrimeiroCase,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.amber,
                  brightness: Brightness.dark,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    log("Pressionado botao 2 case!");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.qr_code_2),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("Segundo Case"),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 10),
              child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.lightBlue,
                  brightness: Brightness.dark,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    print("Pressionado botao 3 case!");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.account_box),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("Terceiro Case"),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 25),
              child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.red,
                  brightness: Brightness.dark,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    log("Pressionado botao 4 case!");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.cloud),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text("Quarto Case"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
