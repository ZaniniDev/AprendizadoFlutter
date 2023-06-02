import 'package:flutter/material.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';
  List<String> tickets = [];

  readQRCode() async {
    // String code = await FlutterBarcodeScanner.scanBarcode(
    //   "#FFFFFF",
    //   "Cancelar",
    //   true,
    //   ScanMode.QR,
    // );
    // setState(() => ticket = code != '-1' ? code : 'Não validado');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //if(ticket != '')
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                'Tickets: ${ticket.length}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton.icon(
              onPressed: readQRCode,
              icon: Icon(Icons.qr_code),
              label: Text("Validar"),
            )
          ],
        ),
      ),
    );
  }
}
