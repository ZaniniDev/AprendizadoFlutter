import 'package:flutter_cases/case_4/controllers/aluno_controller.dart';
import 'package:flutter_cases/case_4/controllers/login_controller.dart';
import 'package:provider/provider.dart';

final providers = [
  // Adicione mais providers aqui, se necessário
  ChangeNotifierProvider<AlunosController>(
    create: (context) => AlunosController(),
  ),
  ChangeNotifierProvider<LoginController>(
    create: (context) => LoginController(),
  ),
];
