import 'package:flutter/material.dart';
import 'package:flutter_cases/case_1/home_case_1.dart';
import 'package:flutter_cases/case_2/home_case_2.dart';
import 'package:flutter_cases/case_4/controllers/login_controller.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/view/pages/alterar_senha.dart';

import 'package:flutter_cases/case_4/view/pages/aluno_cadastrar.dart';
import 'package:flutter_cases/case_4/view/pages/aluno_editar.dart';
import 'package:flutter_cases/case_4/view/pages/aluno_listar.dart';
import 'package:flutter_cases/case_4/view/pages/home_case_4.dart';
import 'package:flutter_cases/case_4/view/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'home.dart';

// aqui vamos configurar nossas rotas do flutter.
// o intuito das rotas é deixar a estruturação das paginas mais organizada
final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      //aqui vamos definir nossa rota principal
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return PaginaInicial();
      },
      routes: <RouteBase>[
        GoRoute(
          name: "case_1_home",
          path: 'case1/home',
          builder: (BuildContext context, GoRouterState state) {
            return PerguntasApp();
          },
        ),
        GoRoute(
          name: "case_2_home",
          path: 'case2/home',
          builder: (BuildContext context, GoRouterState state) {
            return AppQrCode();
          },
        ),
        GoRoute(
          name: "case_4_login",
          path: 'case_4_login',
          builder: (BuildContext context, GoRouterState state) {
            final loginController = Provider.of<LoginController>(context);

            if (loginController.autenticado == true) {
              return PageHomeAlunos();
            } else {
              return PageLoginAluno();
            }
          },
        ),
        GoRoute(
          name: "case_4_aluno_adicionar",
          path: 'case4/aluno/adicionar',
          builder: (BuildContext context, GoRouterState state) {
            return PageCadastrarAluno();
          },
        ),
        GoRoute(
          name: "case_4_home",
          path: 'case4/home',
          builder: (BuildContext context, GoRouterState state) {
            return PageHomeAlunos();
          },
        ),
        GoRoute(
          name: "case_4_aluno_listar",
          path: 'case4/alunos',
          builder: (BuildContext context, GoRouterState state) {
            return PageAlunosListagem();
          },
        ),
        GoRoute(
          name: "case_4_aluno_editar",
          path: 'case4/aluno/editar',
          builder: (BuildContext context, GoRouterState state) {
            //transformamos em Json pois o queryParameters é do tipo Map<String, String>
            //logo não é possivel passar o objeto diretamente via parametro
            Aluno? aluno = Aluno.fromJson(state.queryParameters['aluno']!);
            return PageEditarAluno(
              aluno: aluno,
            );
          },
        ),
        GoRoute(
          name: "case_4_aluno_editarsenha",
          path: 'case4/aluno/editarsenha',
          builder: (BuildContext context, GoRouterState state) {
            //transformamos em Json pois o queryParameters é do tipo Map<String, String>
            //logo não é possivel passar o objeto diretamente via parametro
            return PageEditarSenha();
          },
        ),
        //
      ],
    ),
  ],
);
