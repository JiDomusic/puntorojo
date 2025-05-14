import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubirNosotrosScreen extends StatefulWidget {
  @override
  _SubirNosotrosScreenState createState() => _SubirNosotrosScreenState();
}

class _SubirNosotrosScreenState extends State<SubirNosotrosScreen> {
  final TextEditingController _descripcionController = TextEditingController();

  Future<void> _guardarNosotros() async {
    try {
      await FirebaseFirestore.instance.collection('nosotros').doc('informacion').set({
        'descripcion': _descripcionController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Información guardada exitosamente')));
      _descripcionController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al guardar la información: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subir Información de Nosotros')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción de Nosotros'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarNosotros,
              child: Text('Guardar Información'),
            ),
          ],
        ),
      ),
    );
  }
}
