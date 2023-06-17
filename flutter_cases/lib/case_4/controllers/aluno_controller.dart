import 'package:flutter/foundation.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/repository/aluno_repository.dart';
import 'package:flutter_cases/utils/Status.dart';

class AlunosController extends ChangeNotifier {
  List<Aluno> alunos = [];
  late Aluno alunoLogado;
  late String textoFiltro;

  Status status = Status.sucesso;

  Future<bool> adicionarAluno(Aluno aluno) async {
    setStatus(Status.carregando);
    if (await exiteRaAluno(aluno.ra!)) {
      setStatus(Status.sucesso);
      return false;
    }
    bool criouAluno = false;
    String idNovoAluno = await AlunoRepository.criarAluno(aluno);
    if (idNovoAluno != "") {
      aluno.id = idNovoAluno;
      alunos.add(aluno);
      criouAluno = true;
    }
    setStatus(Status.sucesso);
    notifyListeners();
    return criouAluno;
  }

  Future<List<Aluno>> carregarAlunos() async {
    setStatus(Status.carregando);
    alunos = await AlunoRepository.getAlunos();
    setStatus(Status.sucesso);
    notifyListeners();
    return alunos;
  }

  void limparAlunos() {
    alunos.clear();
    notifyListeners();
  }

  Future<bool> deleterAluno(Aluno aluno) async {
    setStatus(Status.carregando);

    bool deletou = await AlunoRepository.deletarAluno(aluno);
    if (deletou == true) {
      alunos.removeWhere((element) => element.id == aluno.id);
    }
    setStatus(Status.sucesso);
    notifyListeners();
    return deletou;
  }

  Future<bool> editarAluno(Aluno alunoEditado) async {
    setStatus(Status.carregando);
    bool atualizouAluno = await AlunoRepository.editarAluno(alunoEditado);

    if (atualizouAluno == true) {
      int index = alunos.indexWhere((t) => t.id == alunoEditado.id);
      if (index != -1) {
        alunos[index] = alunoEditado;
      }
    }
    setStatus(Status.sucesso);
    notifyListeners();
    return atualizouAluno;
  }

  Future<bool> exiteRaAluno(String ra) async {
    bool existeRaAluno = await AlunoRepository.procuraRA(ra);
    return existeRaAluno;
  }

  void setStatus(Status statusSet) {
    status = statusSet;
    notifyListeners();
  }
}
