import 'package:flutter/material.dart';

class NosotrosPage extends StatelessWidget {
  const NosotrosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nosotros'),
      ),
      body: const Center(
        child: Text('Contenido de la sección Nosotros'),
      ),
    );
  }
}
