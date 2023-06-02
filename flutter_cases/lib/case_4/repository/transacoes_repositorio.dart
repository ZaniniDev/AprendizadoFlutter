import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cases/case_4/Transacao.dart';
import 'package:flutter_cases/case_4/models/transacao_model.dart';

class TransacoesRepository {
  //Instantiate Firestore
  static final db = FirebaseFirestore.instance;

  static List<Transacao> transacoes = [];

  static Future<bool> criarTransacao(TransacaoModel transacaoModel) async {
    final docRef = db.collection('transacoes').doc();
    bool criouTransacao = false;

    transacaoModel.id = docRef.id;
    await docRef.set(transacaoModel.toMap()).then((value) {
      print("Transação inserida com sucesso!");
      criouTransacao = true;
    }, onError: (e) => print("Error na criação da transação : $e"));
    return criouTransacao;
  }

  static Future<List<Transacao>> getTransacoes(String conta_id) async {
    await db
        .collection("transacoes")
        .orderBy("dataTransacao", descending: true)
        .where("conta_id", isEqualTo: conta_id)
        .get()
        .then(
      (querySnapshot) {
        transacoes = [];
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          transacoes.add(Transacao.fromRepository(docSnapshot.data()));
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return transacoes;
  }

  static Future<bool> deletarTransacao(String idTransacao) async {
    bool removeu = false;
    await db.collection('transacoes').doc(idTransacao).delete().then(
      (querySnapshot) {
        print("Transação: " + idTransacao + " removido com sucesso!");
        removeu = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    print(removeu);
    return removeu;
  }

  static Future<bool> atualizarTransacao(TransacaoModel transacaoModel) async {
    bool atualizou = false;
    final String idTransacao = transacaoModel.id!;
    await db
        .collection('transacoes')
        .doc(idTransacao)
        .update(transacaoModel.toMap())
        .then(
      (querySnapshot) {
        print("Transação: " + idTransacao + " editada com sucesso!");
        atualizou = true;
      },
      onError: (e) => print("Error completing: $e"),
    );
    print(atualizou);
    return atualizou;
  }
}
