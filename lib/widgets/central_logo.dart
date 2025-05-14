import 'package:flutter/material.dart';

class CentralLogo extends StatelessWidget {
  final String logoPath;

  const CentralLogo({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logoPath,
      width: 150,
      height: 150,
      fit: BoxFit.contain,
    );
  }
}
