import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionContentPage extends StatelessWidget {
  final String sectionId;
  final String sectionName; // Ejemplo: "inicio", "nosotros"

  const SectionContentPage({
    super.key,
    required this.sectionId,
    required this.sectionName, required String collectionName, required String title,
  });

  @override
  Widget build(BuildContext context) {
    final collectionName = '${sectionName}_$sectionId';

    return Scaffold(
      appBar: AppBar(
        title: Text("${sectionName[0].toUpperCase()}${sectionName.substring(1)} - ${sectionId[0].toUpperCase()}${sectionId.substring(1)}"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(collectionName)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay contenido disponible.'));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final title = data['title'] ?? '';
              final description = data['description'] ?? '';
              final videoUrl = data['videoUrl'] ?? '';

              return Card(
                margin: const EdgeInsets.only(bottom: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title.isNotEmpty)
                        Text(title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      if (description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(description,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      // Contenedor vacío para los videos
                      if (videoUrl.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            height: 200, // Ajusta el tamaño del contenedor
                            width: double.infinity,
                            color: Colors.grey[300], // Color de fondo para el contenedor vacío
                            child: Center(
                              child: videoUrl.contains('youtube')
                                  ? AspectRatio(
                                aspectRatio: 16 / 9,
                                child: InkWell(
                                  onTap: () async {
                                    final uri = Uri.parse(videoUrl);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      // Imagen de previsualización del video de YouTube
                                      Image.network(
                                        'https://img.youtube.com/vi/${_getYoutubeId(videoUrl)}/0.jpg',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                      const Center(
                                        child: Icon(Icons.play_circle,
                                            color: Colors.white, size: 64),
                                      )
                                    ],
                                  ),
                                ),
                              )
                                  : const Text('No es un video de YouTube'),
                            ),
                          ),
                        ),
                      // Contenedor vacío adicional si lo necesitas para más cosas
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getYoutubeId(String url) {
    final uri = Uri.parse(url);
    if (uri.host.contains("youtube.com")) {
      return uri.queryParameters['v'] ?? '';
    } else if (uri.host.contains("youtu.be")) {
      return uri.pathSegments.first;
    }
    return '';
  }
}
