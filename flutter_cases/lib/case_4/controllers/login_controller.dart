import 'package:flutter/foundation.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/repository/login_repository.dart';
import 'package:flutter_cases/case_4/services/criptografiaSenha.dart';
import 'package:flutter_cases/utils/Status.dart';

class LoginController with ChangeNotifier {
  late Aluno alunoLogado;
  Status status = Status.sucesso;
  bool autenticado = false;

  Future<Aluno> logarAluno(ra, senha) async {
    String senhaCriptografada = Criptografia.criptografarTexto(senha);
    setStatus(Status.carregando);
    alunoLogado = await LoginRepository.verificaLogin(ra, senhaCriptografada);
    if (alunoLogado.id != null) {
      autenticado = true;
    } else {
      autenticado = false;
    }
    setStatus(Status.sucesso);
    notifyListeners();
    return alunoLogado;
  }

  bool deslogar() {
    alunoLogado = Aluno();
    autenticado = false;
    return true;
  }

  void setStatus(Status statusSet) {
    status = statusSet;
    notifyListeners();
  }
}
