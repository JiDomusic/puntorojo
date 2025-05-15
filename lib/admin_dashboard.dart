import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _textController = TextEditingController();
  final _urlController = TextEditingController();
  String message = '';

  Future<void> _submit() async {
    final videoData = {
      'titulo': _titleController.text,
      'descripcion': _descriptionController.text,
      'texto': _textController.text,
      'url': _urlController.text,
      'timestamp': Timestamp.now(),
    };

    await FirebaseFirestore.instance.collection('videos').add(videoData);

    setState(() {
      message = '✅ Video subido con éxito';
    });

    _titleController.clear();
    _descriptionController.clear();
    _textController.clear();
    _urlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Texto'),
            ),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'URL de YouTube'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: const Text('Subir Video')),
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(message, style: const TextStyle(color: Colors.green)),
              ),
          ],
        ),
      ),
    );
  }
}
