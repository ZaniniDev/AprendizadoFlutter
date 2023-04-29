import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Buttons Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Buttons Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('ElevatedButton'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text('TextButton'),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {},
                child: Text('OutlinedButton'),
              ),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () {},
                child: Text('MaterialButton'),
              ),
              SizedBox(height: 20),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
              SizedBox(height: 20),
              DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text('Option 1'),
                    value: 'Option 1',
                  ),
                  DropdownMenuItem(
                    child: Text('Option 2'),
                    value: 'Option 2',
                  ),
                  DropdownMenuItem(
                    child: Text('Option 3'),
                    value: 'Option 3',
                  ),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.save),
              ),
              SizedBox(height: 20),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text('Option 1'),
                    value: 'Option 1',
                  ),
                  PopupMenuItem(
                    child: Text('Option 2'),
                    value: 'Option 2',
                  ),
                  PopupMenuItem(
                    child: Text('Option 3'),
                    value: 'Option 3',
                  ),
                ],
                onSelected: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Diferença entre alguns dos principais botões do Material Dart na versão mais atualizada do Flutter:

ElevatedButton: é um botão com uma elevação que indica ações principais. Ele possui um preenchimento (background) que muda de cor quando pressionado. É adequado para ações primárias na interface do usuário.

TextButton: é um botão sem elevação e sem preenchimento que mostra apenas texto. É adequado para ações secundárias ou terciárias. Ele geralmente é usado para cancelar ou descartar ações.

OutlinedButton: é um botão sem preenchimento que mostra uma borda quando é pressionado. É adequado para ações secundárias que precisam ser destacadas.

MaterialButton: é um botão genérico que não possui elevação, preenchimento ou borda por padrão. Ele permite personalizar a aparência do botão, incluindo a cor, a forma e a altura. Pode ser usado em diferentes contextos, dependendo da personalização.

FloatingActionButton: é um botão circular que flutua acima do conteúdo da tela. Ele geralmente é usado para ações primárias e de destaque, como iniciar uma nova tarefa ou adicionar um novo item.

DropdownButton: é um botão que exibe uma lista de opções quando é pressionado. Ele é adequado para ações que exigem que o usuário escolha entre várias opções.

IconButton: é um botão que exibe um ícone em vez de texto. Ele é adequado para ações comuns ou primárias que podem ser realizadas em uma única etapa, como salvar ou compartilhar.

PopupMenuButton: é um botão que exibe um menu de opções quando é pressionado. Ele é adequado para ações que exigem que o usuário escolha entre várias opções, mas com uma quantidade maior de opções do que as apresentadas no DropdownButton.
*/ 