import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/controllers/transacoes_controller.dart';
import 'package:flutter_cases/case_4/controllers/usuarios_controller.dart';
import 'package:provider/provider.dart';

final providers = [
  ChangeNotifierProvider<TransacoesController>(
    create: (context) => TransacoesController(),
  ),
  ChangeNotifierProvider<UsuariosController>(
    create: (context) => UsuariosController(),
  ),
  ChangeNotifierProvider<ContasUsuarioController>(
    create: (context) => ContasUsuarioController(),
  ),
  // Adicione mais providers aqui, se necessário
];
