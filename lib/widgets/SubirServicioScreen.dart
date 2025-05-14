import 'package:flutter/material.dart';

class SubirServicioScreen extends StatefulWidget {
  @override
  _SubirServicioScreenState createState() => _SubirServicioScreenState();
}

class _SubirServicioScreenState extends State<SubirServicioScreen> {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  // Función para subir el servicio (Simulada)
  void _subirServicio() {
    final link = _linkController.text;
    final descripcion = _descripcionController.text;

    if (link.isNotEmpty && descripcion.isNotEmpty) {
      // Aquí puedes agregar la lógica para guardar estos datos en Firestore
      // Por ejemplo, usar Firestore.instance.collection('servicios').add({...})

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Servicio subido correctamente'),
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
      appBar: AppBar(title: Text('Subir Servicio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Enlace de YouTube'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción del Servicio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _subirServicio,
              child: Text('Subir Servicio'),
            ),
          ],
        ),
      ),
    );
  }
}
