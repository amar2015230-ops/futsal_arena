
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/field_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FieldProvider(),
      child: const FutsalArenaApp(),
    ),
  );
}

class FutsalArenaApp extends StatelessWidget {
  const FutsalArenaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Futsal Arena',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),

      home: const HomeScreen(),
    );
  }
}
