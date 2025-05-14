import 'package:flutter/material.dart';

class TestimoniosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Testimonios')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Testimonios de Clientes', style: TextStyle(fontSize: 24)),
            // Aquí puedes cargar dinámicamente testimonios desde Firestore
            Container(
              padding: EdgeInsets.all(16),
              child: Text('Aquí irán los testimonios', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
