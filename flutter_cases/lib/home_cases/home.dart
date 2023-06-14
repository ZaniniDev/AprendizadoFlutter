import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cases/case_3/services/notificacaoService.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
                      context.goNamed("case_1_home");
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
                        context.goNamed("case_2_home");
                        print("Pressionado botao 2 case!");
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
                          context.goNamed("case_3_home");
                          print("Pressionado botao 3 case!");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
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
                          context.goNamed("case_4_login");
                          print("Pressionado botao 4 case!");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
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
          unselectedItemColor: Colors.purple,
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
          onTap: (value) async {
            if (value == 0) {
              await criarNotificacaoExemplo();
              // context.pushNamed("case_4_aluno_listar");
            } else if (value == 1) {
              // context.pushNamed("case_4_home");
            } else if (value == 2) {
              await Geolocator.requestPermission();
              Position posicao = await Geolocator.getCurrentPosition();
              String latitude = posicao.latitude.toString();
              String longitude = posicao.longitude.toString();
              List<Placemark> lugaresCordenada = await placemarkFromCoordinates(
                  posicao.latitude, posicao.longitude);
              List<Endereco> enderecos = [];

              for (var lugarCordenada in lugaresCordenada) {
                String nomeRua = lugarCordenada.street!;
                String pais = lugarCordenada.country!;
                String cep = lugarCordenada.postalCode!;
                String estado = lugarCordenada.administrativeArea!;
                String cidade = lugarCordenada.subAdministrativeArea!;
                String bairro = lugarCordenada.subLocality!;
                String numero = lugarCordenada.subThoroughfare!;
                bool enderecoExistente = enderecos.any((endereco) {
                  return (endereco.nomeRua.contains(nomeRua) ||
                      endereco.cep == cep);
                });
                //verificacao se ja existe o endereço dentro dos endereços
                //e caso o cep estiver vazio, provavelmente o endereço esta errado
                if (enderecoExistente == false && cep != "") {
                  enderecos.add(Endereco(
                    nomeRua: nomeRua,
                    pais: pais,
                    cep: cep,
                    estado: estado,
                    cidade: cidade,
                    bairro: bairro,
                    numero: numero,
                  ));
                }
              }
              showAlertDialogInfoLocalizacao(
                  context, latitude, longitude, enderecos);
              // context.pushNamed("case_4_aluno_adicionar");
            }
          }),
    );
  }
}

class Endereco {
  String nomeRua;
  String pais;
  String cep;
  String estado;
  String cidade;
  String bairro;
  String numero;

  Endereco({
    required this.nomeRua,
    required this.pais,
    required this.cep,
    required this.estado,
    required this.cidade,
    required this.bairro,
    required this.numero,
  });

  @override
  String toString() {
    return 'País: $pais, '
        'Nome da rua: $nomeRua, '
        'CEP: $cep, '
        'Estado: $estado, '
        'Cidade: $cidade, '
        'Bairro: $bairro, '
        'Número: $numero';
  }
}

showAlertDialogInfoLocalizacao(BuildContext context, String latitude,
    String longitude, List<Endereco> enderecos) {
  // set up the buttons
  Widget fecharButton = TextButton(
    child: Text("Fechar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Localização Atual"),
    content: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text("Latitude: ${latitude} Longitude: ${longitude}"),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text("Possíveis Endereços:"),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: enderecos.length,
                itemBuilder: (context, index) {
                  Endereco endereco = enderecos[index];
                  return ListTile(
                    title:
                        Text(endereco.nomeRua + ", Número:" + endereco.numero),
                    subtitle: Text(
                        '${endereco.cidade}, ${endereco.estado} - ${endereco.cep} - ${endereco.bairro}'),
                    trailing: Text(endereco.pais),
                  );
                },
              ),
            ],
          ),
        );
      },
    ),
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

Future<void> criarNotificacaoExemplo() async {
  NotificacaoService notificacaoService = NotificacaoService();
  await notificacaoService.mostrarNotificacao(
    0,
    "Push Notificação teste!",
    "Horário da Notificação: " +
        DateFormat("dd/MM/yyyy HH:mm:s").format(DateTime.now()) +
        ".",
    jsonEncode({
      "title": "Notificação JSON Teste!",
      "eventDate": DateFormat("EEEE, d MMM y").format(DateTime.now())
    }),
  );
}
