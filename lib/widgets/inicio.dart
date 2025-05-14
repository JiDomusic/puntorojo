import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio Productora')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Bienvenidos a la Productora', style: TextStyle(fontSize: 24)),
            // Contenedor de texto y otros widgets con datos estáticos
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.blueAccent,
              child: Text('Descripción Estática de la Productora', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            // Aquí puedes mostrar datos dinámicos desde Firestore si es necesario
          ],
        ),
      ),
    );
  }
}
