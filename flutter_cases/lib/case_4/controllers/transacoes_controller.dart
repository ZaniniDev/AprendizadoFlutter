import 'package:flutter/foundation.dart';
import 'package:flutter_cases/case_4/Status.dart';
import 'package:flutter_cases/case_4/Transacao.dart';
import 'package:flutter_cases/case_4/models/transacao_model.dart';
import 'package:flutter_cases/case_4/repository/transacoes_repositorio.dart';

class TransacoesController extends ChangeNotifier {
  List<Transacao> transacoes = [];
  List<Transacao> transacoesFiltro = [];
  bool iniciou = false;
  bool filtroAtivado = false;
  double saldoAtual = 0;
  double saldoFiltro = 0;

  Status status =
      Status.sucesso; //comecar com carregando para garantir que seja carregado

  Future<bool> adicionarTransacao(Transacao transacao) async {
    TransacaoModel transacaoModel = TransacaoModel.fromTransacao(transacao);
    bool criouTransacao =
        await TransacoesRepository.criarTransacao(transacaoModel);
    return criouTransacao;
  }

  Future<List<Transacao>> carregarTransacoes(String conta_id) async {
    setStatus(Status.carregando);
    transacoes = await TransacoesRepository.getTransacoes(conta_id);
    transacoesFiltro = transacoes;
    calcularSaldoAtual();
    // print("Carregou " + transacoes.length.toString() + " transações.");
    setStatus(Status.sucesso);
    notifyListeners();
    return transacoes;
  }

  void limparTransacoes() {
    transacoes.clear();
    transacoesFiltro.clear();
    saldoAtual = 0;
    saldoFiltro = 0;
    iniciou = false;
    notifyListeners();
  }

  Future<bool> deleterTransacao(String idTransacao) async {
    setStatus(Status.carregando);

    bool deletou = await TransacoesRepository.deletarTransacao(idTransacao);
    if (deletou == true) {
      transacoes.removeWhere((element) => element.id == idTransacao);
      transacoesFiltro.removeWhere((element) => element.id == idTransacao);
    }
    setStatus(Status.sucesso);
    notifyListeners();
    return deletou;
  }

  Future<bool> atualizarTransacao(Transacao transacaoEditada) async {
    setStatus(Status.carregando);

    TransacaoModel transacaoModel =
        TransacaoModel.fromTransacao(transacaoEditada);
    bool atualizouTransacao =
        await TransacoesRepository.atualizarTransacao(transacaoModel);

    if (atualizouTransacao == true) {
      int index = transacoes.indexWhere((t) => t.id == transacaoEditada.id);
      if (index != -1) {
        transacoes[index] = transacaoEditada;
      }
      int indexFiltro =
          transacoesFiltro.indexWhere((t) => t.id == transacaoEditada.id);
      if (indexFiltro != -1) {
        transacoesFiltro[indexFiltro] = transacaoEditada;
      }
    }
    setStatus(Status.sucesso);
    notifyListeners();
    return atualizouTransacao;
  }

  void setStatus(Status statusSet) {
    status = statusSet;
    notifyListeners();
  }

  void setSaldoAtual(double _saldo) {
    saldoAtual = _saldo;
    notifyListeners();
  }

  double calcularSaldoAtual() {
    double saldo = 0;
    for (var transacao in transacoes) {
      if (transacao.tipoTransacao.toLowerCase() == "entrada") {
        saldo += transacao.valor;
      } else {
        saldo -= transacao.valor;
      }
    }
    saldoAtual = saldo;
    return saldo;
  }

  double calcularSaldoFiltro() {
    double saldo = 0;
    for (var transacao in transacoesFiltro) {
      if (transacao.tipoTransacao.toLowerCase() == "entrada") {
        saldo += transacao.valor;
      } else {
        saldo -= transacao.valor;
      }
    }
    saldoFiltro = saldo;
    return saldo;
  }

  // Método para filtrar as transações com base no tipo de transação
  void filtrarPorTipoTransacao(String tipo) {
    print("Tipo filtro -> " + tipo);
    transacoesFiltro = transacoes
        .where((transacao) =>
            transacao.tipoTransacao.toLowerCase() == tipo.toLowerCase())
        .toList();
    saldoFiltro = calcularSaldoFiltro();
    notifyListeners();
  }

  // Método para filtrar as transações com base no formato de transferência
  void filtrarPorFormatoTransferencia(String formato) {
    transacoesFiltro = transacoes
        .where((transacao) => transacao.formatoTransferencia == formato)
        .toList();
    saldoFiltro = calcularSaldoFiltro();
    notifyListeners();
  }

  // Método para filtrar as transações com base no nome
  void filtrarPorNome(String nome) {
    transacoesFiltro = transacoes
        .where((transacao) =>
            transacao.nome.toLowerCase().contains(nome.toLowerCase()))
        .toList();
    saldoFiltro = calcularSaldoFiltro();
    notifyListeners();
  }

  // Método para filtrar as transações com base no valor
  void filtrarPorValor(double valor) {
    transacoesFiltro =
        transacoes.where((transacao) => transacao.valor == valor).toList();
    saldoFiltro = calcularSaldoFiltro();
    notifyListeners();
  }

  // Método para filtrar as transações com base na categoria
  void filtrarPorCategoria(String categoria) {
    transacoesFiltro = transacoes
        .where((transacao) => transacao.categoria == categoria)
        .toList();
    saldoFiltro = calcularSaldoFiltro();
    notifyListeners();
  }

  void filtrarPorIntervaloDeDatas(DateTime? dataInicial, DateTime? dataFinal) {
    setStatus(Status.carregando);
    DateTime? dataFinalFiltro = dataFinal;
    if (dataInicial == null && dataFinal == null) {
      transacoesFiltro = transacoes;
      return;
    }

    if (dataFinalFiltro == null) {
      // Caso a data final não seja fornecida, considera a maior data das transações
      dataFinalFiltro = transacoes
          .map((transacao) => transacao.dataTransacao)
          .reduce((maxDate, currentDate) =>
              maxDate.isAfter(currentDate) ? maxDate : currentDate);
    }

    transacoesFiltro = transacoes.where((transacao) {
      final transacaoData = transacao.dataTransacao;
      return (dataInicial == null || transacaoData.isAfter(dataInicial)) &&
          transacaoData.isBefore(dataFinalFiltro!);
    }).toList();

    saldoFiltro = calcularSaldoFiltro();
    notifyListeners();
  }
}
