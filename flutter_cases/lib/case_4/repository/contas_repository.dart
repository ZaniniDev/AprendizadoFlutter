import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cases/case_4/Conta.dart';
import 'package:flutter_cases/case_4/models/conta_model.dart';

class ContasRepository {
  //Instantiate Firestore
  static final db = FirebaseFirestore.instance;

  static List<Conta> contas = [];

  static Future<bool> criarConta(ContaModel contaModel) async {
    final docRef = db.collection('contas').doc();
    bool criouConta = false;

    contaModel.id = docRef.id;
    await docRef.set(contaModel.toMap()).then((value) {
      print("Conta criada com sucesso!");
      criouConta = true;
    }, onError: (e) => print("Error na criação da conta : $e"));
    return criouConta;
  }

  static Future<List<Conta>> getContas(String titular_id) async {
    await db
        .collection("contas")
        .where("titular_id", isEqualTo: titular_id)
        .get()
        .then(
      (querySnapshot) {
        contas = [];
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          contas.add(Conta.fromRepository(docSnapshot.data()));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return contas;
  }

  static Future<bool> deletarConta(String idConta) async {
    bool removeu = false;
    await db.collection('contas').doc(idConta).delete().then(
      (querySnapshot) {
        print("Conta: " + idConta + " removida com sucesso!");
        removeu = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    print(removeu);
    return removeu;
  }

  static Future<bool> atualizarConta(ContaModel contaModel) async {
    bool atualizou = false;
    final String idConta = contaModel.id!;
    await db.collection('contas').doc(idConta).update(contaModel.toMap()).then(
      (querySnapshot) {
        print("Conta: " + idConta + " editada com sucesso!");
        atualizou = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    print(atualizou);
    return atualizou;
  }
}
