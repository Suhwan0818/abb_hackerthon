import 'package:flutter/material.dart';
import 'homeLayout.dart';
import 'notification_service.dart';

void main() async {
  final notificationService = NotificationService();
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF0F0F0)),
      home: const HomePageLayout(),
    );
  }
}
