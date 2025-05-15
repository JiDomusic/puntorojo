import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Videos extends StatelessWidget {
  const Videos({super.key});

  String? _extractYoutubeId(String url) {
    final cleanUrl = url.trim();
    final uri = Uri.tryParse(cleanUrl);
    if (uri == null) return null;
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay videos disponibles.'));
          }

          final videos = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              final videoId = _extractYoutubeId(video['url']);

              return Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['titulo'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (video['descripcion'] != null &&
                        video['descripcion'].toString().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          video['descripcion'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    if (video['texto'] != null &&
                        video['texto'].toString().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          video['texto'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    const SizedBox(height: 12),
                    if (videoId != null)
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: YoutubePlayerIFrame(
                            controller: YoutubePlayerController(
                              initialVideoId: videoId,
                              params: const YoutubePlayerParams(
                                showFullscreenButton: true,
                                showControls: true,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      const Text(
                        'URL de YouTube no válida',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
