import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Controladores para los campos de texto
  final TextEditingController _textController = TextEditingController();

  // Para manejar el estado de los datos dinámicos
  bool _loading = false;

  // Salir de la sesión
  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Función para agregar un servicio a Firestore
  Future<void> _addService() async {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _loading = true;
      });

      try {
        await _firestore.collection('servicios').add({
          'titulo': _textController.text,
          'descripcion': 'Descripción del servicio',
          'fecha_creacion': Timestamp.now(),
        });

        setState(() {
          _loading = false;
          _textController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Servicio agregado con éxito')));
      } catch (e) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al agregar servicio: $e')));
      }
    }
  }

  // Función para agregar un testimonio a Firestore
  Future<void> _addTestimonial() async {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _loading = true;
      });

      try {
        await _firestore.collection('testimonios').add({
          'testimonio': _textController.text,
          'autor': 'Nombre del autor',
          'fecha_creacion': Timestamp.now(),
        });

        setState(() {
          _loading = false;
          _textController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Testimonio agregado con éxito')));
      } catch (e) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al agregar testimonio: $e')));
      }
    }
  }

  // Función para agregar un proyecto social a Firestore
  Future<void> _addProject() async {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _loading = true;
      });

      try {
        await _firestore.collection('proyectos').add({
          'titulo': _textController.text,
          'descripcion': 'Descripción del proyecto social',
          'fecha_creacion': Timestamp.now(),
        });

        setState(() {
          _loading = false;
          _textController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proyecto social agregado con éxito')));
      } catch (e) {
        setState(() {
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al agregar proyecto social: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Admin Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Agregar Servicio
                Text('Agregar un Servicio', style: TextStyle(fontSize: 18)),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Escribe el título del servicio'),
                ),
                ElevatedButton(
                  onPressed: _addService,
                  child: Text('Agregar Servicio'),
                ),
                Divider(),
                // Agregar Testimonio
                Text('Agregar Testimonio', style: TextStyle(fontSize: 18)),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Escribe el testimonio'),
                ),
                ElevatedButton(
                  onPressed: _addTestimonial,
                  child: Text('Agregar Testimonio'),
                ),
                Divider(),
                // Agregar Proyecto Social
                Text('Agregar Proyecto Social', style: TextStyle(fontSize: 18)),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'Escribe el título del proyecto'),
                ),
                ElevatedButton(
                  onPressed: _addProject,
                  child: Text('Agregar Proyecto Social'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
