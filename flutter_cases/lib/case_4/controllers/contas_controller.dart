import 'package:flutter/foundation.dart';
import 'package:flutter_cases/case_4/Conta.dart';
import 'package:flutter_cases/case_4/Status.dart';
import 'package:flutter_cases/case_4/models/conta_model.dart';
import 'package:flutter_cases/case_4/repository/contas_repository.dart';

class ContaController {
  static String conta_id = "PgZAuynDWughUPYbuqIH";
}

class ContasUsuarioController extends ChangeNotifier {
  List<Conta> contas = [];

  Status status =
      Status.sucesso; //comecar com carregando para garantir que seja carregado

  void setStatus(Status statusSet) {
    status = statusSet;
    notifyListeners();
  }

  Future<bool> adicionarConta(Conta conta) async {
    setStatus(Status.carregando);
    ContaModel contaModel = ContaModel.fromConta(conta);
    bool criouConta = await ContasRepository.criarConta(contaModel);
    setStatus(Status.sucesso);
    return criouConta;
  }

  // Future<List<Transacao>> carregarTransacoes(String conta_id) async {
  //   setStatus(Status.carregando);
  //   transacoes = await TransacoesRepository.getTransacoes(conta_id);
  //   transacoesFiltro = transacoes;
  //   calcularSaldoAtual();
  //   // print("Carregou " + transacoes.length.toString() + " transações.");
  //   setStatus(Status.sucesso);
  //   notifyListeners();
  //   return transacoes;
  // }

  // Future<bool> deleterTransacao(String idTransacao) async {
  //   setStatus(Status.carregando);

  //   bool deletou = await TransacoesRepository.deletarTransacao(idTransacao);
  //   if (deletou == true) {
  //     transacoes.removeWhere((element) => element.id == idTransacao);
  //     transacoesFiltro.removeWhere((element) => element.id == idTransacao);
  //   }
  //   setStatus(Status.sucesso);
  //   notifyListeners();
  //   return deletou;
  // }

  // void setSaldoAtual(double _saldo) {
  //   saldoAtual = _saldo;
  //   notifyListeners();
  // }

  // double calcularSaldoAtual() {
  //   double saldo = 0;
  //   for (var transacao in transacoes) {
  //     if (transacao.tipoTransacao.toLowerCase() == "entrada") {
  //       saldo += transacao.valor;
  //     } else {
  //       saldo -= transacao.valor;
  //     }
  //   }
  //   saldoAtual = saldo;
  //   return saldo;
  // }
}
