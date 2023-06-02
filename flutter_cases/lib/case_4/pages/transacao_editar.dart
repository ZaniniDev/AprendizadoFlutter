import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/Transacao.dart';
import 'package:flutter_cases/case_4/components/TransacaoComponents.dart';
import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/controllers/transacoes_controller.dart';
import 'package:flutter_cases/case_4/repository/usuario_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaginaEditarTransacao extends StatefulWidget {
  final Transacao transacao;
  const PaginaEditarTransacao({super.key, required this.transacao});

  @override
  State<PaginaEditarTransacao> createState() => _PageEditarTransacaoState();
}

enum OpcoesTipoTransacao { debito, credito }

class _PageEditarTransacaoState extends State<PaginaEditarTransacao> {
  @override
  late Transacao _transacao = widget.transacao;
  late String? id = _transacao.id;
  late String? nome = _transacao.nome;
  late String? descricao = _transacao.descricao;
  late String? categoria = _transacao.categoria;
  late double? valor = _transacao.valor;
  late String? valorInicial = widget.transacao.valor.toStringAsFixed(2);
  late String? tipoTransacao = _transacao.tipoTransacao;
  late String? formaTransferencia = _transacao.formatoTransferencia;
  late DateTime? dataTransacao =
      widget.transacao.dataTransacao ?? DateTime.now();

  final _formKey = GlobalKey<FormState>();

  void atualizarTransacao() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processando os dados...')),
      );
      print("ID: " +
          id.toString() +
          "Nome:" +
          nome.toString() +
          " Valor:" +
          valor.toString() +
          " TipoTransacao:" +
          tipoTransacao.toString() +
          " Forma transferencia:" +
          formaTransferencia.toString() +
          " Data Transacao:" +
          dataTransacao.toString());

      final String usuario_id = UsuarioRepository.usuario_id;
      final String conta_id = ContaController.conta_id;
      Transacao transacaoForms = new Transacao(
          id: id,
          usuario_id: usuario_id,
          conta_id: conta_id,
          nome: nome!,
          valor: valor!,
          tipoTransacao: tipoTransacao!,
          formatoTransferencia: formaTransferencia!,
          categoria: categoria,
          descricao: descricao,
          dataTransacao: dataTransacao!);
      print(transacaoForms.toJson());
      TransacoesController controller =
          Provider.of<TransacoesController>(context, listen: false);
      await controller.atualizarTransacao(transacaoForms);
      Future.delayed(const Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transação Atualizada!')),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Transação"),
        backgroundColor: Colors.green,
      ),
      body: Theme(
        data: ThemeData(
          primarySwatch: Colors.green,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextFormField(
                  // controller: _nomeController,
                  initialValue: nome,
                  decoration:
                      InputDecoration(labelText: 'Nome', suffixText: '*'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe o nome da transação.';
                    }
                    return null;
                  },
                  onSaved: (_nome) {
                    nome = _nome!;
                  },
                ),
                TextFormField(
                  // controller: _descricaoController,
                  initialValue: descricao,
                  decoration: InputDecoration(labelText: 'Descrição'),
                  onSaved: (_descricao) {
                    if (_descricao != null) {
                      descricao = _descricao;
                    }
                  },
                ),
                TextFormFieldValorTransacao(
                  initialValue: valorInicial!.replaceAll('.', ','),
                  onSaved: (_valor) {
                    valor = double.tryParse(
                        _valor!.replaceAll('.', '').replaceAll(',', '.'))!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Categoria'),
                  onSaved: (_categoria) {
                    categoria = _categoria!;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Tipo da transação:",
                    textAlign: TextAlign.start,
                  ),
                ),
                DropdownTipoTransacao(
                  tipoTransacao: tipoTransacao,
                  onChanged: (String? value) => setState(() {
                    tipoTransacao = value ?? "";
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Forma de tranferência",
                    textAlign: TextAlign.start,
                  ),
                ),
                DropdownFormaTransferencia(
                  formaTransferencia: formaTransferencia,
                  onChanged: (String? value) => setState(() {
                    formaTransferencia = value ?? "";
                  }),
                ),
                TextFormFieldDataTransacao(
                  initialValue: DateFormat('dd/MM/yyyy').format(dataTransacao!),
                  onSaved: (_dataTransacao) {
                    dataTransacao =
                        new DateFormat("dd/MM/yyyy").parse(_dataTransacao!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Theme(
            data: ThemeData(
              primarySwatch: Colors.green,
            ),
            child: ElevatedButton.icon(
              icon: Icon(Icons.refresh),
              label: Text('Editar'),
              onPressed: atualizarTransacao,
            )),
      ),
    );
  }
}
