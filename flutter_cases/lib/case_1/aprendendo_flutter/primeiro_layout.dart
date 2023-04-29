import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: PaginaInicial(),
    debugShowCheckedModeBanner:
        false, //essa linha retira a fita que fica de debug no canto superior direito
  ));
}

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar = topo da pagina, como se fosse um header
      appBar: AppBar(
        //title = é o titulo do appbar
        title: Text('TCC Flutter'),
        //actions = parte superior direito do appbar
        actions: <Widget>[
          //utilizamos Icon Button para
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.quiz),
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
            icon: Icon(Icons.cloud),
          ),
        ],
      ),
      body: Container(
        //padding = é a distancia que o nosso container vai ter sobre as bordas
        //no flutter usamos o EdgeInsets para setar os valores dessas distancias
        //para setar a direção voce precisa chamar um metodo para onde vai direcionar
        //os principais sao o metodo .all(todos as direcoes) e o .only(direcao especifica)
        //vamos usar o .all que cria uma distancia entre todas as bordas
        padding: EdgeInsets.all(10),
        child: Column(
          //o mainaxisalignment é o alinhamento principal
          //como estamos usando coluna então o mainAxisAlignment é vertical
          //abaixo estamos falando para ele deixar um espaço padrão entre todos
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "APRENDIZADO DA LINGUAGEM FLUTTER",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Container(
              //vamos utilizar nosso primeiro exemplo de botão
              //o elevatedbutton utiliza um background, por padrão sua cor é do tema
              //vamos utilizar o metodo .icon para criar um botão com icone
              child: ElevatedButton.icon(
                onPressed: () {},
                //atenção no parametro icon: Ele não recebe diretamente o Icone.help
                //ele recebe uma instancia de Icon, e o IconHelp é uma istancia de IconData
                //Por exemplo Conta() não é == ContaCorrente() ou Conta() não é == ContaPoupanca()
                //Então Icon != IconData
                icon: Icon(
                  Icons.help,
                  size: 24,
                ),
                //usamos label para indicar o texto
                label: Text("Tutorial"),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 10),
              //neste botão queremos que ele preencha a linha toda
              //usamos o elevatedbutton com o child: Row para o preenchimento de toda linha
              child: ElevatedButton(
                onPressed: () {
                  //vamos printar quando pressionarmos este botão
                  print("Pressionado botao 1 case!");
                },
                //no Row vamos definir nosso icone e o texto do nosso botão
                child: Row(
                  //alinhamento central de tudo que vamos colcar no botão(icone, texto)
                  mainAxisAlignment: MainAxisAlignment.center,
                  //reforçando que aqui no Row(children:) é para colocar nossos Widgets
                  //Icone e texto no caso do Elevated Button
                  children: const <Widget>[
                    Icon(Icons.quiz),
                    //o padding é utilizado novamente para definir
                    //distancia entre o child: e o elemento antes dele
                    //Distancia entre o Texto e o Icone
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Primeiro Case"),
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  print("Pressionado botao 2 case!");
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
            Container(
              alignment: Alignment.bottomCenter,
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
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  print("Pressionado botao 4 case!");
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
          ],
        ),
      ),
    );
  }
}
