import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';

class AlunoRepository {
  //Instantiate Firestore
  static final db = FirebaseFirestore.instance;

  static Future<bool> criarAluno(Aluno aluno) async {
    final docRef = db.collection('alunos').doc();
    bool criouAluno = false;

    aluno.id = docRef.id;
    await docRef.set(aluno.toMap()).then((value) {
      print("Aluno inserido com sucesso!");
      criouAluno = true;
    }, onError: (e) => print("Error na criação do aluno : $e"));
    return criouAluno;
  }

  static Future<List<Aluno>> getAlunos() async {
    List<Aluno> alunos = [];
    await db.collection("alunos").orderBy("nome", descending: false).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          alunos.add(Aluno.fromMap(docSnapshot.data()));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return alunos;
  }

  static Future<bool> deletarAluno(Aluno aluno) async {
    String idAluno = aluno.id!;
    bool removeu = false;
    await db.collection('alunos').doc(idAluno).delete().then(
      (querySnapshot) {
        print("Aluno: " + aluno.nome! + " removido com sucesso!");
        removeu = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    print(removeu);
    return removeu;
  }

  static Future<bool> editarAluno(Aluno aluno) async {
    bool atualizou = false;
    String idAluno = aluno.id!;
    await db.collection('alunos').doc(idAluno).update(aluno.toMap()).then(
      (querySnapshot) {
        print("Aluno: " + aluno.nome! + " editada com sucesso!");
        atualizou = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    print(atualizou);
    return atualizou;
  }
}
