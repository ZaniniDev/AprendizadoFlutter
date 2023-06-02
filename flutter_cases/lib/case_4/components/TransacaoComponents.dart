import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFormFieldValorTransacao extends StatelessWidget {
  final String? initialValue;

  final ValueChanged<String?> onSaved;

  TextFormFieldValorTransacao({
    Key? key,
    this.initialValue,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //controller: _valorController,
      decoration:
          InputDecoration(labelText: "Valor da Transação", suffixText: '*'),
      keyboardType: TextInputType.number,
      initialValue: initialValue,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor, informe o valor da transação.';
        }
        if (value.contains(".")) {
          return 'Não é permitido ponto, somente vírgulas!';
        }

        try {
          double _valor =
              double.tryParse(value.replaceAll('.', '').replaceAll(',', '.'))!;
          if (_valor <= 0) {
            return 'Por favor, informe um valor maior que 0.';
          }
        } catch (e) {
          return 'Por favor, informe um valor válido da transação.';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}

class TextFormFieldDataTransacao extends StatelessWidget {
  final String? initialValue;
  final ValueChanged<String?> onSaved;

  TextFormFieldDataTransacao({
    Key? key,
    this.initialValue,
    required this.onSaved,
  }) : super(key: key);

  bool verificarData(String dataString) {
    try {
      DateFormat formatador = DateFormat('dd/MM/yyyy');
      formatador.parseStrict(dataString);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Data da Transação'),
      inputFormatters: [MaskTextInputFormatter(mask: "##/##/####")],
      // value DateFormat('dd-MM-yyyy').format(pickedDate);
      initialValue: initialValue != null
          ? initialValue
          : DateFormat('dd/MM/yyyy').format(DateTime.now()),
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
      onSaved: onSaved,
    );
  }
}

class DropdownTipoTransacao extends StatelessWidget {
  final listTipoTransacao = ["Entrada", "Saída"];
  final String? tipoTransacao;
  final ValueChanged<String?> onChanged;

  DropdownTipoTransacao({
    Key? key,
    this.tipoTransacao,
    required this.onChanged,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: _createListTipoTransacao(),
      hint: Text("Escolha o tipo da transação"),
      value: tipoTransacao,
      onChanged: onChanged,
    );
  }
}

class DropdownFormaTransferencia extends StatelessWidget {
  final listFormaTransferencia = [
    "Pix",
    "Dinheiro",
    "Cartão de Crédito",
    "Cartão de Débito",
    "VR/VA"
  ];
  final String? formaTransferencia;
  final ValueChanged<String?> onChanged;

  DropdownFormaTransferencia({
    Key? key,
    this.formaTransferencia,
    required this.onChanged,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: _createListFormaTransferencia(),
      hint: Text("Escolha uma forma de transferência"),
      value: formaTransferencia != null
          ? formaTransferencia
          : listFormaTransferencia[0],
      onChanged: onChanged,
    );
  }
}
