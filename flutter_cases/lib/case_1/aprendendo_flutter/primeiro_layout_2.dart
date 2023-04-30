import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
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
        backgroundColor: Colors.blue,
        //title = é o titulo do appbar
        title: Text('TCC Flutter'),
        //actions = parte superior direito do appbar
        actions: <Widget>[
          //iconbutton = widget que tem como parametros o icone e o onpressed
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.flashlight_on),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Aprendizado Flutter",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print("Pressionado botao 1 case!");
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.quiz),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Primeiro Case",
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      descPrimeiroCase,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  )
                  //colocamos o text para descrevermos como será o case 1,2..
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data: ThemeData(
                  primarySwatch: Colors.amber,
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        log("Pressionado botao 2 case!");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white),
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
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "O segundo case retrata como aprendemos a utilizar os recursos nativos de hardware mobile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                        ),
                      ),
                    )
                  ],
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
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Pressionado botao 3 case!");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white),
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
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "O terceiro case retrata como aprendemos a utilizar os recursos nativos de software mobile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 25),
              child: Theme(
                  data: ThemeData(
                    primarySwatch: Colors.red,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          log("Pressionado botao 4 case!");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white),
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
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "O quarto case retrata como aprendemos a utilizar os recurso de armazenamento de dados em nuvem utilizando Flutter",
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
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Colors.blue,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 24,
            ),
            label: "Push Notificação",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 36,
              ),
              label: ("Home")),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.location_on,
                size: 24,
              ),
              label: ("Localização")),
        ],
      ),
    );
  }
}
