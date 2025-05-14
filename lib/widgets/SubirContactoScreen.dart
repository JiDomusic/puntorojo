import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubirContactoScreen extends StatefulWidget {
  @override
  _SubirContactoScreenState createState() => _SubirContactoScreenState();
}

class _SubirContactoScreenState extends State<SubirContactoScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensajeController = TextEditingController();

  Future<void> _guardarContacto() async {
    try {
      await FirebaseFirestore.instance.collection('contactos').add({
        'nombre': _nombreController.text,
        'email': _emailController.text,
        'mensaje': _mensajeController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Contacto guardado exitosamente')));
      _nombreController.clear();
      _emailController.clear();
      _mensajeController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al guardar el contacto: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subir Contacto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: _mensajeController,
              decoration: InputDecoration(labelText: 'Mensaje'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarContacto,
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
