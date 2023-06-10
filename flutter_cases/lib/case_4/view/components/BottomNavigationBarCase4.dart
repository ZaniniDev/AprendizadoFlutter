import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarCase4 extends StatelessWidget {
  final int currentIndex;
  const BottomNavigationBarCase4({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.green,
      fixedColor: Colors.greenAccent,
      unselectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.school,
            size: 24,
          ),
          label: "Alunos",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 36,
            ),
            label: ("Inicio")),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_add_sharp,
              size: 24,
            ),
            label: ("Adicionar Aluno")),
      ],
      onTap: (value) {
        if (value == 0) {
          context.pushNamed("case_4_aluno_listar");
        } else if (value == 1) {
          context.pushNamed("case_4_home");
        } else if (value == 2) {
          context.pushNamed("case_4_aluno_adicionar");
        }
      },
    );
  }
}
