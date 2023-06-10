import 'package:flutter/foundation.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';
import 'package:flutter_cases/case_4/repository/aluno_repository.dart';
import 'package:flutter_cases/case_4/utils/Status.dart';

class AlunosController extends ChangeNotifier {
  List<Aluno> alunos = [];
  late Aluno alunoLogado;
  Status status = Status.sucesso;

  Future<bool> adicionarAluno(Aluno aluno) async {
    bool criouAluno = await AlunoRepository.criarAluno(aluno);
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

  void setStatus(Status statusSet) {
    status = statusSet;
    notifyListeners();
  }
}
