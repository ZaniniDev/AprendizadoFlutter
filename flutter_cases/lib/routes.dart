import 'package:flutter/material.dart';
import 'package:flutter_cases/case_1/home_case_1.dart';
import 'package:flutter_cases/case_2/home_case_2.dart';
import 'package:flutter_cases/case_4/Transacao.dart';
import 'package:flutter_cases/case_4/controllers/usuarios_controller.dart';
import 'package:flutter_cases/case_4/pages/transacao_adicionar.dart';
import 'package:flutter_cases/case_4/pages/contas_adicionar.dart';
import 'package:flutter_cases/case_4/pages/contas_editar.dart';
import 'package:flutter_cases/case_4/pages/transacao_editar.dart';
import 'package:flutter_cases/case_4/pages/home_case_4.dart';
import 'package:flutter_cases/case_4/pages/contas_listagem.dart';
import 'package:flutter_cases/case_4/pages/login_page.dart';
import 'package:flutter_cases/case_4/pages/transacoes_listagem.dart';
import 'package:go_router/go_router.dart';
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
        //AppQrCode
        GoRoute(
          name: "case_4_home",
          path: 'case4/home',
          builder: (BuildContext context, GoRouterState state) {
            return const Case4Home();
          },
        ),
        //colocamos na rota a pagina de adicionar transação
        GoRoute(
          name: "case_4_transacoes_adicionar",
          path: 'case4/transacoes/adicionar',
          builder: (BuildContext context, GoRouterState state) {
            return PaginaAdicionaTransacao();
          },
        ),
        GoRoute(
          name: "case_4_login_page",
          path: 'case_4_login_page',
          builder: (BuildContext context, GoRouterState state) {
            if (UsuariosController.autenticado == true) {
              return Case4Home();
            } else {
              return Case4_LoginPage();
            }
          },
        ),
        GoRoute(
          name: "case_4_transacoes",
          path: 'case4/transacoes',
          builder: (BuildContext context, GoRouterState state) {
            return TransacoesPage();
          },
        ),
        GoRoute(
          name: "case_4_contas",
          path: 'case4/contas',
          builder: (BuildContext context, GoRouterState state) {
            return MinhasContasPage();
          },
        ),
        GoRoute(
          name: "case_4_transacoes_editar",
          path: 'case4/transacoes/editar',
          builder: (BuildContext context, GoRouterState state) {
            Transacao? transacao =
                Transacao.fromJson(state.queryParameters['transacao']!);
            return PaginaEditarTransacao(
              transacao: transacao,
            );
          },
        ),
        GoRoute(
          name: "case_4_contas_editar",
          path: 'case4/contas/editar',
          builder: (BuildContext context, GoRouterState state) {
            return PaginaEditarConta();
          },
        ),
        GoRoute(
          name: "case_4_contas_adicionar",
          path: 'case4/contas/adicionar',
          builder: (BuildContext context, GoRouterState state) {
            return PaginaAdicionarConta();
          },
        ),
      ],
    ),
  ],
);
