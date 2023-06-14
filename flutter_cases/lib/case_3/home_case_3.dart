import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'pagina_detalhes.dart';
import 'services/notificacaoService.dart';
import 'componentes/selecionadorDiaPersonalizado.dart';
import 'componentes/campoData.dart';
import 'componentes/cabecalho.dart';
import 'componentes/campoTempo.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  _EstadoPaginaPrincipal createState() => _EstadoPaginaPrincipal();
}

class _EstadoPaginaPrincipal extends State<PaginaPrincipal> {
  NotificacaoService notificacaoService = NotificacaoService();
  final _formKey = GlobalKey<FormState>();

  final int comprimentoMaximoTitulo = 60;
  TextEditingController _controladorEdicaoTexto =
      TextEditingController(text: "Reunião de negócios");

  int valorGrupoControleSegmentado = 0;

  DateTime dataAtual = DateTime.now();
  DateTime? dataEvento = DateTime.now();

  TimeOfDay horaAtual = TimeOfDay.now();
  TimeOfDay? horaEvento = TimeOfDay.now();

  Future<void> onCreate() async {
    if (_formKey.currentState!.validate()) {
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
        1,
        _controladorEdicaoTexto.text,
        "Lembrete para seu evento agendado em ${horaEvento!.format(context)}",
        dataEvento!,
        horaEvento!,
        jsonEncode({
          "title": _controladorEdicaoTexto.text,
          "eventDate": DateFormat("EEEE, d MMM y").format(dataEvento!),
          "eventTime": horaEvento!.format(context),
        }),
        getDateTimeComponents(),
      );
      resetForm();
    }
  }

  Future<void> cancelAllNotifications() async {
    await notificacaoService.cancelarTodasNotificacoes();
  }

  void resetForm() {
    valorGrupoControleSegmentado = 0;
    dataEvento = DateTime.now();
    horaEvento = TimeOfDay.now();
    _controladorEdicaoTexto.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Impede o redimensionamento da área do conteúdo quando o teclado é ativado
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Aplicativo de lembretes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => paginaDetalhes(payload: null),
                ),
              );
            },
            icon: Icon(Icons.library_books_rounded),
          ),
        ],
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
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        await cancelAllNotifications();
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

  DateTimeComponents? getDateTimeComponents() {
    if (valorGrupoControleSegmentado == 1) {
      return DateTimeComponents.time;
    } else if (valorGrupoControleSegmentado == 2) {
      return DateTimeComponents.dayOfWeekAndTime;
    }
  }

  void selectEventDate() async {
    final today = DateTime(dataAtual.year, dataAtual.month, dataAtual.day);
    if (valorGrupoControleSegmentado == 0) {
      dataEvento = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: new DateTime(dataAtual.year + 10),
      );
      setState(() {});
    } else if (valorGrupoControleSegmentado == 1) {
      dataEvento = today;
    } else if (valorGrupoControleSegmentado == 2) {
      CustomDayPicker(
        onDaySelect: (val) {
          print("$val: ${CustomDayPicker.weekdays[val]}");
          dataEvento = today.add(
              Duration(days: (val - today.weekday + 1) % DateTime.daysPerWeek));
        },
      ).show(context);
    }
  }
}
