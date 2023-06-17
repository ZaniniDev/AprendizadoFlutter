import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificacaoService {
  // Singleton pattern
  static final NotificacaoService _notificacaoService =
      NotificacaoService._internal();
  factory NotificacaoService() {
    return _notificacaoService;
  }

  NotificacaoService._internal();

  static const canalId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    canalId,
    "case_notificacao",
    channelDescription:
        "Este canal é responsável por todas as notificações locais",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  // static final IOSNotificationDetails _iOSNotificacaoDetalhes =
  // IOSNotificationDetails();

  final NotificationDetails notificacaoDetalhes = NotificationDetails(
    android: _androidNotificationDetails,
  );

  Future<void> init() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("icon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    // *** Inicialize o fuso horário aqui ***
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> solicitarPermissoesIOS() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> solicitarPermissoesAndroid() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  Future<void> mostrarNotificacao(
      int id, String titulo, String corpo, String payload) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      titulo,
      corpo,
      notificacaoDetalhes,
      payload: payload,
    );
  }

  Future<void> agendarNotificacao(int id, String titulo, String corpo,
      DateTime eventDate, TimeOfDay eventTime, String payload,
      [DateTimeComponents? dateTimeComponents]) async {
    final scheduledTime = eventDate.add(Duration(
      hours: eventTime.hour,
      minutes: eventTime.minute,
    ));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      titulo,
      corpo,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificacaoDetalhes,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payload,
      matchDateTimeComponents: dateTimeComponents,
    );
  }

  Future<void> cancelarNotificacao(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelarTodasNotificacoes() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

// Future<void> selecionarNotificacao(String? payload) async {
//   final GlobalKey<NavigatorState> navigatorKey =
//       new GlobalKey<NavigatorState>();
//   await navigatorKey.currentState?.push(
//       MaterialPageRoute(builder: (_) => paginaDetalhes(payload: payload)));
// }
