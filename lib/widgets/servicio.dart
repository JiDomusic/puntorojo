import 'package:flutter/material.dart';

class ServicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Servicios')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Servicios Audiovisuales', style: TextStyle(fontSize: 24)),
            // Puedes cargar dinámicamente los links de YouTube desde Firestore
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Aquí se listan los servicios', style: TextStyle(fontSize: 18)),
                  // Simulación de video de YouTube
                  // Este widget podría estar basado en Firestore
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
