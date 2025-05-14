import 'package:flutter/material.dart';

class SubirTestimoniosScreen extends StatefulWidget {
  @override
  _SubirTestimoniosScreenState createState() => _SubirTestimoniosScreenState();
}

class _SubirTestimoniosScreenState extends State<SubirTestimoniosScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _testimonioController = TextEditingController();
  final TextEditingController _enlaceController = TextEditingController();

  // Función para subir el testimonio (Simulada)
  void _subirTestimonio() {
    final nombre = _nombreController.text;
    final testimonio = _testimonioController.text;
    final enlace = _enlaceController.text;

    if (nombre.isNotEmpty && testimonio.isNotEmpty && enlace.isNotEmpty) {
      // Aquí puedes agregar la lógica para guardar estos datos en Firestore
      // Ejemplo: Firestore.instance.collection('testimonios').add({...});

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Testimonio subido correctamente'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, completa todos los campos'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subir Testimonio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre del Testimonio'),
            ),
            TextField(
              controller: _testimonioController,
              decoration: InputDecoration(labelText: 'Testimonio'),
              maxLines: 5,
            ),
            TextField(
              controller: _enlaceController,
              decoration: InputDecoration(labelText: 'Enlace del Testimonio (opcional)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _subirTestimonio,
              child: Text('Subir Testimonio'),
            ),
          ],
        ),
      ),
    );
  }
}
