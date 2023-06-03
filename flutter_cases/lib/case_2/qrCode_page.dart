import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      true,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
  }

  lerCodigoBarras() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      true,
      ScanMode.BARCODE,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
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
                'Tickets: ${ticket}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton.icon(
              onPressed: readQRCode,
              icon: Icon(Icons.qr_code),
              label: Text("QRCODE"),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton.icon(
              onPressed: lerCodigoBarras,
              icon: Icon(CupertinoIcons.barcode),
              // icon: Icon(Icons.scan)
              label: Text("Código de Barras"),
            )
          ],
        ),
      ),
    );
  }
}
