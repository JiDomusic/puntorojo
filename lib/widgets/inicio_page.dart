import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  Future<List<Map<String, dynamic>>> fetchContent() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('inicio')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final content = snapshot.data ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Bienvenidos a Casa Cultural Inga',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Explorá nuestros proyectos, arte, cultura y audiovisuales.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              const Text(
                'Videos Recientes',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              ...content.map((item) => _buildVideoCard(item)).toList(),

              const SizedBox(height: 32),
              const Text(
                'Galería de Fotos',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildImageGallery(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVideoCard(Map<String, dynamic> item) {
    final title = item['title'] ?? 'Sin título';
    final description = item['description'] ?? '';
    final link = item['youtubeLink'] ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.play_circle_outline),
        onTap: () async {
          final uri = Uri.parse(link);
          if (await canLaunchUrl(uri)) {
            launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      ),
    );
  }

  Widget _buildImageGallery() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(4, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/gallery_$index.jpg',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        );
      }),
    );
  }
}
