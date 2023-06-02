import 'package:flutter_cases/case_4/repository/usuario_repository.dart';
import 'package:flutter/foundation.dart';

class UsuariosController with ChangeNotifier {
  static String usuario = "";
  static String senha = "";
  static bool autenticado = false;
  static String id = "";

  static auth() async {
    bool autenticacaoLogin =
        await UsuarioRepository.verificaLogin(usuario, senha);

    if (autenticacaoLogin) {
      id = UsuarioRepository.usuario_id;
      autenticado = true;
      return true;
    }
    return false;
  }
}
