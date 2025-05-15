import 'package:flutter/material.dart';

class contacto_inga extends StatelessWidget {
  const contacto_inga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nombre de la Sección')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Título de la Sección',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Aquí puedes colocar una descripción larga, párrafos de texto o cualquier otro contenido relevante a esta sección.\n\nEste archivo puede ser personalizado con imágenes, videos o formularios.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Aquí puedes incrustar una imagen de assets por ejemplo:
            // Image.asset('assets/images/ejemplo.jpg'),
          ],
        ),
      ),
    );
  }
}