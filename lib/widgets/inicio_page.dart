import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';  // Paquete actualizado para YouTube
import 'package:url_launcher/url_launcher.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  // Método para abrir un enlace
  Future<void> _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'No se puede abrir el enlace: $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página de Inicio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Columna Izquierda (dinámica con imágenes fijas y links de Firestore)
            Expanded(
              flex: 1,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('contenido_izquierda').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error al cargar los datos.'));
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final texto = data['texto'] ?? 'Sin texto';
                      final youtubeLink = data['youtube_link'] ?? '';
                      final imageUrl = data['imagen_url'] ?? '';

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(texto, style: Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8),
                              youtubeLink.isNotEmpty
                                  ? YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: YoutubePlayer.convertUrlToId(youtubeLink)!,
                                  flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
                                ),
                              )
                                  : Container(),
                              const SizedBox(height: 8),
                              imageUrl.isNotEmpty
                                  ? Image.network(imageUrl) // Imagen dinámica desde Firestore
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Columna Derecha (dinámica con imágenes fijas y links de Firestore)
            Expanded(
              flex: 1,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('contenido_derecha').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error al cargar los datos.'));
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final texto = data['texto'] ?? 'Sin texto';
                      final youtubeLink = data['youtube_link'] ?? '';
                      final imageUrl = data['imagen_url'] ?? '';

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(texto, style: Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: 8),
                              youtubeLink.isNotEmpty
                                  ? YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: YoutubePlayer.convertUrlToId(youtubeLink)!,
                                  flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
                                ),
                              )
                                  : Container(),
                              const SizedBox(height: 8),
                              imageUrl.isNotEmpty
                                  ? Image.network(imageUrl) // Imagen dinámica desde Firestore
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Sección de contacto al pie de la página
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon:  Icon(Icons.instagram),
              onPressed: () => _launchURL('https://instagram.com/tu_perfil'),
            ),
            IconButton(
              icon:  Icon(Icons.whatsapp),
              onPressed: () => _launchURL('https://wa.me/1234567890'),
            ),
            IconButton(
              icon: const Icon(Icons.mail),
              onPressed: () => _launchURL('mailto:correo@ejemplo.com'),
            ),
          ],
        ),
      ),
    );
  }
}
