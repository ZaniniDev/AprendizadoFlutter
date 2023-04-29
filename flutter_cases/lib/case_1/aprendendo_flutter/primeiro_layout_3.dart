import 'package:flutter/material.dart';

void main() {
  runApp(const PaginaInicial());
}

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar appBarHome = AppBar(
      title: Text('Flutter Cases'),
      actions: const <Widget>[
        //actions = parte superior direito do appbar
        IconButtonTheme(
          //icone com botão, que é um widget
          data: IconButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
            ),
          ),
          child: IconButton(onPressed: null, icon: Icon(Icons.qr_code_2)),
        )
      ],
    );
    return MaterialApp(
      title: 'Flutter Primeiro Layout',
      home: Scaffold(
        appBar: appBarHome,
        body: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('button pressed!');
                    },
                    child: Text('Next'),
                  ),
                  SizedBox(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.battery_1_bar_outlined),
                      label: Text("Primeiro Case"),
                      style: TextButton.styleFrom(
                        primary: Colors.grey,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.battery_3_bar),
                    label: Text("Segundo Case"),
                    style: TextButton.styleFrom(
                      primary: Colors.amber,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.battery_5_bar),
                    label: Text("Terceiro Case"),
                    style: TextButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.battery_full),
                    label: Text("Quarto Case"),
                    style: TextButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
