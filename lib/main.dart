import 'package:agendamento_postagens/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

