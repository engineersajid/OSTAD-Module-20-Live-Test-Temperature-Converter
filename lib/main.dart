import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/viewmodels/temperature_viewmodel.dart';
import 'presentation/views/temperature_converter_screen.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: ChangeNotifierProvider(
        create: (_) => TemperatureViewModel(),
        child: const TemperatureConverterScreen(),
      ),
    );
  }
}