import 'package:flutter/material.dart';

class SubirProyectosScreen extends StatefulWidget {
  @override
  _SubirProyectosScreenState createState() => _SubirProyectosScreenState();
}

class _SubirProyectosScreenState extends State<SubirProyectosScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _enlaceController = TextEditingController();

  // Función para subir un proyecto (Simulada)
  void _subirProyecto() {
    final nombre = _nombreController.text;
    final descripcion = _descripcionController.text;
    final enlace = _enlaceController.text;

    if (nombre.isNotEmpty && descripcion.isNotEmpty && enlace.isNotEmpty) {
      // Aquí puedes agregar la lógica para guardar estos datos en Firestore
      // Ejemplo: Firestore.instance.collection('proyectos').add({...});

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Proyecto subido correctamente'),
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
      appBar: AppBar(title: Text('Subir Proyecto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre del Proyecto'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción del Proyecto'),
              maxLines: 5,
            ),
            TextField(
              controller: _enlaceController,
              decoration: InputDecoration(labelText: 'Enlace del Proyecto'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _subirProyecto,
              child: Text('Subir Proyecto'),
            ),
          ],
        ),
      ),
    );
  }
}
