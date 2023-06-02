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
            Icons.attach_money,
            size: 24,
          ),
          label: "Transações",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 36,
            ),
            label: ("Inicio")),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance,
              size: 24,
            ),
            label: ("Contas")),
      ],
      onTap: (value) {
        if (value == 0) {
          context.pushReplacementNamed("case_4_transacoes");
        } else if (value == 1) {
          context.pushReplacementNamed("case_4_home");
        } else if (value == 2) {
          context.pushReplacementNamed("case_4_contas");
        }
      },
    );
  }
}
