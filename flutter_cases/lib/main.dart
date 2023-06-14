import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cases/case_3/services/notificacaoService.dart';
import 'package:flutter_cases/providers.dart';
import 'package:flutter_cases/routes.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificacaoService notificacaoService = NotificacaoService();
  await notificacaoService.init();
  await notificacaoService.solicitarPermissoesIOS();
  await notificacaoService.solicitarPermissoesAndroid();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e);
    print("Erro na inicializacao do firebase");
  }

  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}
