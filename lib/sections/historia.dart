import 'package:flutter/material.dart';

class Historia extends StatelessWidget {
  const Historia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuestra Historia'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título principal
            const Text(
              'El nacimiento de un colectivo',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),

            // Imagen decorativa (podés reemplazar por una asset tuya)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),

            // Texto emotivo
            const Text(
              'Somos más que un grupo audiovisual; somos una familia  que hue huie hue bla ble bvla.',
              style: TextStyle(fontSize: 20, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cada proyecto que emprendemos es un trabajo cooperativo  QUE  GUA GUEUBAJDHSAJD, '
                  'creando un mosaico de  we wew e  dsadhiadh .',
              style: TextStyle(fontSize: 18, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'ajdasjdhhasd kdsfhldsukfh  wawewewew   awaaaawaaaaa y awaWWEAEAEAEAEEA',
              style: TextStyle(fontSize: 18, height: 1.4),
            ),
            const SizedBox(height: 24),

            // Frase destacada
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '" sarasa  sarararsa sa sa sajsajsa ."',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            // Cierre con invitación
            const Text(
              'Te invitamos  bla le  la a slalsandlaksdbkasbjkbd dfdf lleno de creatividad, '
                  'bla ble bla bla  , y bla blo bli blu.',
              style: TextStyle(fontSize: 18, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
