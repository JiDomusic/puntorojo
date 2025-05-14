import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logo Central',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Logo Central'),
        ),
        body: const Center(
          child: CentralLogo(logoPath: 'assets/images/puntorojo2.jpg'),
        ),
      ),
    );
  }
}

class CentralLogo extends StatelessWidget {
  final String logoPath;

  const CentralLogo({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logoPath,
      width: 180,
      height: 180,
      fit: BoxFit.contain,
    );
  }
}

