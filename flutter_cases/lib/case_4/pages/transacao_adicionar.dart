import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/Transacao.dart';
import 'package:flutter_cases/case_4/controllers/contas_controller.dart';
import 'package:flutter_cases/case_4/controllers/transacoes_controller.dart';
import 'package:flutter_cases/case_4/repository/usuario_repository.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class PaginaAdicionaTransacao extends StatefulWidget {
  const PaginaAdicionaTransacao({super.key});

  @override
  State<PaginaAdicionaTransacao> createState() => _PageAdicionaTransacaoState();
}

enum OpcoesTipoTransacao { debito, credito }

class _PageAdicionaTransacaoState extends State<PaginaAdicionaTransacao> {
  @override
  late String nome;
  String descricao = "";
  String categoria = "";
  late double valor;
  final _formKey = GlobalKey<FormState>();
  bool verificarData(String dataString) {
    try {
      DateFormat formatador = DateFormat('dd/MM/yyyy');
      formatador.parseStrict(dataString);
      return true;
    } catch (e) {
      return false;
    }
  }

  DateTime dataTransacao = DateTime.now();

  final listTipoTransacao = ["Entrada", "Saída"];
  late String tipoTransacao = listTipoTransacao[0];
  List<DropdownMenuItem<String>> _createListTipoTransacao() {
    return listTipoTransacao
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  final listFormaTransferencia = [
    "Pix",
    "Dinheiro",
    "Cartão de Crédito",
    "Cartão de Débito",
    "VR/VA"
  ];
  late String formaTransferencia = listFormaTransferencia[0];
  List<DropdownMenuItem<String>> _createListFormaTransferencia() {
    return listFormaTransferencia
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        )
        .toList();
  }

  void adicionarTransacao() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processando os dados...')),
      );
      print("Nome:" +
          nome +
          " Valor:" +
          valor.toString() +
          " TipoTransacao:" +
          tipoTransacao.toString() +
          " Forma transferencia:" +
          formaTransferencia.toString() +
          " Data Transacao:" +
          dataTransacao.toString());

      await _adicionarTransacao(Transacao(
          nome: nome,
          valor: valor,
          tipoTransacao: tipoTransacao,
          formatoTransferencia: formaTransferencia,
          categoria: categoria,
          descricao: descricao,
          dataTransacao: dataTransacao));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transação Criada!')),
      );
    }
  }

  Future<void> _adicionarTransacao(Transacao t) async {
    // Lógica para adicionar a transação
    t.usuario_id = UsuarioRepository.usuario_id;
    t.conta_id = ContaController.conta_id;
    TransacoesController controller =
        Provider.of<TransacoesController>(context, listen: false);
    await controller.adicionarTransacao(t);
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
                  decoration: InputDecoration(labelText: 'Descrição'),
                  validator: (value) {
                    // if (value!.isEmpty) {
                    //   return 'Por favor, informe a descrição da transação.';
                    // }
                    return null;
                  },
                  onSaved: (_descricao) {
                    if (_descricao != null) {
                      descricao = _descricao;
                    }
                  },
                ),
                TextFormField(
                  //controller: _valorController,
                  decoration:
                      InputDecoration(labelText: 'Valor', suffixText: '*'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe o valor da transação.';
                    }
                    if (value.contains(".")) {
                      return 'Não é permitido ponto, somente vírgulas!';
                    }

                    try {
                      double _valor = double.tryParse(
                          value.replaceAll('.', '').replaceAll(',', '.'))!;
                      if (_valor <= 0) {
                        return 'Por favor, informe um valor maior que 0.';
                      }
                    } catch (e) {
                      return 'Por favor, informe um valor válido da transação.';
                    }
                    return null;
                  },
                  onSaved: (_valor) {
                    valor = double.tryParse(
                        _valor!.replaceAll('.', '').replaceAll(',', '.'))!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Categoria'),
                  validator: (value) {
                    // if (value!.isEmpty) {
                    //   return 'Por favor, informe a categoria da transação.';
                    // }
                    return null;
                  },
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
                DropdownButton(
                  items: _createListTipoTransacao(),
                  hint: Text("Escolha uma o tipo da transação"),
                  value: tipoTransacao,
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
                DropdownButton(
                  items: _createListFormaTransferencia(),
                  hint: Text("Escolha uma forma de transferência"),
                  value: formaTransferencia,
                  onChanged: (String? value) => setState(() {
                    formaTransferencia = value ?? "";
                  }),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Data da Transação'),
                  inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
                  // value DateFormat('dd-MM-yyyy').format(pickedDate);
                  initialValue: DateFormat('dd/MM/yyyy').format(dataTransacao),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe a data da transação.';
                    }
                    bool dataValida = verificarData(value);
                    if (!dataValida) {
                      return 'A data não está no formato correto. Ex: 31/01/2023';
                    }
                    return null;
                  },
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
              icon: Icon(Icons.create),
              label: Text('Adicionar'),
              onPressed: adicionarTransacao,
            )),
      ),
    );
  }
}
