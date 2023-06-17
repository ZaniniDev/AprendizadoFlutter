import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cases/utils/Dialogo.dart';

Future<void> leituraCamera(BuildContext context, ScanMode tipoLeitura) async {
  //é passado via parametros o context para mostrar no popup
  //e o ScanMode que é o tipo de leitura que vai ser realizada (QRCODE ou BarCode)
  String code = await FlutterBarcodeScanner.scanBarcode(
    "#FFFFFF",
    "Cancelar",
    true,
    tipoLeitura,
  );
  if (code != "-1") {
    mostrarDialogoSimples(context, "Código encontrado!", "Código:" + code);
  } else {
    mostrarDialogoSimples(
        context, "Código não encontrado!", "Não foi possível ler o código.");
  }
}

class QRCodePage extends StatefulWidget {
  const QRCodePage({Key? key}) : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.yellow,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.tealAccent,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
            onPrimary: Colors.black,
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                'Selecione a opção de leitura',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await leituraCamera(context, ScanMode.QR);
              },
              icon: Icon(Icons.qr_code_2),
              label: Text("QRCODE"),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            ElevatedButton.icon(
              onPressed: () async {
                await leituraCamera(context, ScanMode.BARCODE);
              },
              icon: Icon(CupertinoIcons.barcode),
              label: Text("Código de Barras"),
            )
          ],
        ),
      ),
    );
  }
}
