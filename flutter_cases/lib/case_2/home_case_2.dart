import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cases/case_2/services/notificacaoService.dart';
import 'package:flutter_cases/case_2/componentes/campoData.dart';
import 'package:flutter_cases/case_2/componentes/cabecalho.dart';
import 'package:flutter_cases/case_2/componentes/campoTempo.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  _EstadoPaginaPrincipal createState() => _EstadoPaginaPrincipal();
}

class _EstadoPaginaPrincipal extends State<PaginaPrincipal> {
  NotificacaoService notificacaoService = NotificacaoService();
  final _formKey = GlobalKey<FormState>();

  final int comprimentoMaximoTitulo = 60;
  TextEditingController _controladorEdicaoTexto = TextEditingController();

  int valorGrupoControleSegmentado = 0;
  int idNotificacao = 1;

  DateTime dataAtual = DateTime.now();
  DateTime? dataEvento;

  TimeOfDay horaAtual = TimeOfDay.now();
  TimeOfDay? horaEvento = TimeOfDay.now();

  Future<void> onCreate() async {
    if (_formKey.currentState!.validate()) {
      if (dataEvento == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("É obrigatório o preenchimento do dia do evento."),
          ),
        );
        return;
      }
      await notificacaoService.mostrarNotificacao(
        0,
        _controladorEdicaoTexto.text,
        "Um novo evento foi criado.",
        jsonEncode({
          "title": _controladorEdicaoTexto.text,
          "eventDate": DateFormat("EEEE, d MMM y").format(dataEvento!),
          "eventTime": horaEvento!.format(context),
        }),
      );
      await notificacaoService.agendarNotificacao(
        idNotificacao,
        _controladorEdicaoTexto.text,
        "Lembrete para seu evento agendado em ${horaEvento!.format(context)}",
        dataEvento!,
        horaEvento!,
        jsonEncode({
          "title": _controladorEdicaoTexto.text,
          "eventDate": DateFormat("EEEE, d MMM y").format(dataEvento!),
          "eventTime": horaEvento!.format(context),
        }),
      );

      resetForm();
    }
  }

  Future<void> cancelarTodasNotificacoes() async {
    await notificacaoService.cancelarTodasNotificacoes();
  }

  void resetForm() {
    setState(() {
      valorGrupoControleSegmentado = 0;
      dataEvento = null;
      horaEvento = TimeOfDay.now();
      _controladorEdicaoTexto.clear();
      idNotificacao += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Impede o redimensionamento da área do conteúdo quando o teclado é ativado
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Case 2 - Software"),
      ),
      body: Theme(
        data: ThemeData(
          primaryColor: Colors.red,
          primarySwatch: Colors.red,
          shadowColor: Colors.red,
          buttonTheme: ButtonThemeData(buttonColor: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Header(),
                    TextFormField(
                      controller: _controladorEdicaoTexto,
                      maxLength: comprimentoMaximoTitulo,
                      decoration: InputDecoration(
                        counterText: "",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Preencha o nome do evento.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text("Data e hora"),
                    SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: selectEventDate,
                      child: DateField(eventDate: dataEvento),
                    ),
                    SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () async {
                        horaEvento = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: horaAtual.hour,
                            minute: horaAtual.minute + 1,
                          ),
                        );
                        setState(() {});
                      },
                      child: TimeField(eventTime: horaEvento),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: onCreate,
                      child: Text("Criar Notificação"),
                    ),
                    SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () async {
                        await cancelarTodasNotificacoes();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Todas as notificações canceladas"),
                          ),
                        );
                      },
                      child: _buildCancelAllButton(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelAllButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.indigo[100],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cancelar todos os lembretes",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Icon(Icons.clear),
        ],
      ),
    );
  }

  void selectEventDate() async {
    if (valorGrupoControleSegmentado == 0) {
      dataEvento = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: new DateTime(dataAtual.year + 10),
      );
      setState(() {});
    }
  }
}
