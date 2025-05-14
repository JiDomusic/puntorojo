import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubirServicios2Screen extends StatefulWidget {
  @override
  _SubirServicios2ScreenState createState() => _SubirServicios2ScreenState();
}

class _SubirServicios2ScreenState extends State<SubirServicios2Screen> {
  final TextEditingController _linkController = TextEditingController();

  Future<void> _guardarServicio2() async {
    try {
      await FirebaseFirestore.instance.collection('servicios2').add({
        'link': _linkController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Link de servicio guardado exitosamente')));
      _linkController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al guardar el link: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subir Servicio 2')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Link de Servicio (YouTube o similar)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarServicio2,
              child: Text('Guardar Link'),
            ),
          ],
        ),
      ),
    );
  }
}
