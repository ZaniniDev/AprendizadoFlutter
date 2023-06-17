import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cases/case_4/models/aluno_model.dart';

class LoginRepository {
  //Instantiate Firestore
  static final db = FirebaseFirestore.instance;

  static Future<Aluno> verificaLogin(ra, senha) async {
    Aluno alunoLogado = Aluno();
    await db
        .collection('alunos')
        .where("ra", isEqualTo: ra)
        .where("senha", isEqualTo: senha)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          alunoLogado = Aluno.fromMap(docSnapshot.data());
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return alunoLogado;
  }
}
