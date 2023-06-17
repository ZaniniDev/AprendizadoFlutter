import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';

class AlunoRepository {
  //Instantiate Firestore
  static final db = FirebaseFirestore.instance;

  static Future<String> criarAluno(Aluno aluno) async {
    final docRef = db.collection('alunos').doc();
    String idAluno = "";
    aluno.id = docRef.id;
    await docRef.set(aluno.toMap()).then((value) {
      // print("Aluno inserido com sucesso!");
      idAluno = aluno.id!;
    }, onError: (e) => print("Error na criação do aluno : $e"));
    return idAluno;
  }

  static Future<List<Aluno>> getAlunos() async {
    List<Aluno> alunos = [];
    await db.collection("alunos").orderBy("nome", descending: false).get().then(
      (querySnapshot) {
        // print("Alunos encontrados:" + querySnapshot.docs.length.toString());
        for (var docSnapshot in querySnapshot.docs) {
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
        // print("Aluno: " + aluno.nome! + " removido com sucesso!");
        removeu = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return removeu;
  }

  static Future<bool> editarAluno(Aluno aluno) async {
    bool atualizou = false;
    String idAluno = aluno.id!;
    await db.collection('alunos').doc(idAluno).update(aluno.toMap()).then(
      (querySnapshot) {
        // print("Aluno: " + aluno.nome! + " editada com sucesso!");
        atualizou = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return atualizou;
  }

  static Future<bool> procuraRA(String raAluno) async {
    bool raEncontrado = false;
    await db.collection("alunos").where("ra", isEqualTo: raAluno).get().then(
      (querySnapshot) {
        if (querySnapshot.docs.length > 0) {
          raEncontrado = true;
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return raEncontrado;
  }
}
