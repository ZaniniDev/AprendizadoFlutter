import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/controllers/usuarios_controller.dart';
import 'package:go_router/go_router.dart';

class Case4_LoginPage extends StatefulWidget {
  const Case4_LoginPage({super.key});

  @override
  State<Case4_LoginPage> createState() => _Case4_LoginPageState();
}

class _Case4_LoginPageState extends State<Case4_LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String usuario = "";
  late String senha = "";

  void initState() {
    super.initState();

    print("Iniciando a tela de login! " + UsuariosController.id);
    print("Usuario autenticado: " + UsuariosController.autenticado.toString());
  }

  @override
  Widget build(BuildContext context) {
    // if (UsuariosController.autenticado) {
    //   context.pushReplacementNamed("case_4");
    // }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.person,
                ),
              ),
              TextFormField(
                // controller: _nomeController,
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Usuário é obrigatório.';
                  }
                  return null;
                },
                onSaved: (_usuario) {
                  usuario = _usuario!;
                },
              ),
              TextFormField(
                // controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Senha é obrigatório.';
                  }
                  return null;
                },
                onSaved: (_senha) {
                  senha = _senha!;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        UsuariosController.usuario = usuario;
                        UsuariosController.senha = senha;
                        bool autenticado = await UsuariosController.auth();
                        if (autenticado) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Usuario Logado!')),
                          );
                          ContaController.conta_id = "PgZAuynDWughUPYbuqIH";
                          await Future.delayed(Duration(seconds: 3));
                          context.pushReplacementNamed("case_4_contas");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Usuario ou senha incorreto!')),
                          );
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Entrar",
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
              ),
              ElevatedButton(
                  onPressed: () async {
                    ContaController.conta_id = "PgZAuynDWughUPYbuqIH";
                    UsuariosController.usuario = "tccgrupo";
                    UsuariosController.senha = "tcc2023";
                    bool autenticado = await UsuariosController.auth();
                    if (autenticado) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuario Logado!')),
                      );
                      ContaController.conta_id = "PgZAuynDWughUPYbuqIH";
                      await Future.delayed(Duration(seconds: 3));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuario Test Logado!')),
                      );
                    }
                    context.pop();
                    context.pushReplacementNamed("case_4_contas");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Entrar sem usuario",
                        textAlign: TextAlign.center,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
