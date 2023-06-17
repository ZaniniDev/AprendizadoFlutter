import 'package:flutter/material.dart';
import 'package:flutter_cases/case_3/components/qrCode_page.dart';

class HomeCase3 extends StatelessWidget {
  const HomeCase3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case 3 - Hardware"),
        backgroundColor: Colors.amber,
      ),
      body: QRCodePage(),
    );
  }
}
