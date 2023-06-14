import 'package:flutter/material.dart';

class CustomDayPicker extends StatelessWidget {
  const CustomDayPicker({Key? key, required this.onDaySelect})
      : super(key: key);
  final ValueChanged<int> onDaySelect;

  Future<bool?> show(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => this,
    );
  }

  static final List<String> weekdays = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sábado',
    'Domingo',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Selecione um dia"),
      content: Wrap(
        alignment: WrapAlignment.center,
        spacing: 3,
        children: [
          for (int index = 0; index < weekdays.length; index++)
            ElevatedButton(
              onPressed: () {
                onDaySelect(index);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.indigo,
                ),
              ),
              child: Text(weekdays[index]),
            ),
        ],
      ),
    );
  }
}
