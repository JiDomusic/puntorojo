import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// Widget para reproducir un video YouTube dado un videoId
class YoutubeVideoPlayerExample extends StatefulWidget {
  final String videoId;
  const YoutubeVideoPlayerExample({required this.videoId, super.key});

  @override
  State<YoutubeVideoPlayerExample> createState() => _YoutubeVideoPlayerExampleState();
}

class _YoutubeVideoPlayerExampleState extends State<YoutubeVideoPlayerExample> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}

// Admin Dashboard para subir videos a Firestore
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
  String? errorText;
  String? _videoId;

  bool _isValidYoutubeUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    final isYoutube = uri.host.contains('youtube.com') && uri.queryParameters.containsKey('v');
    final isShort = uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty;
    return isYoutube || isShort;
  }

  String? _extractYoutubeId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.first;
    }
    return null;
  }

  void _updateVideoPreview() {
    final url = _urlController.text.trim();
    if (_isValidYoutubeUrl(url)) {
      final id = _extractYoutubeId(url);
      if (id != null) {
        setState(() {
          _videoId = id;
          errorText = null;
        });
        return;
      }
    }
    setState(() {
      _videoId = null;
      errorText = '⚠️ URL de YouTube no válida';
    });
  }

  Future<void> _submit() async {
    final url = _urlController.text.trim();
    if (!_isValidYoutubeUrl(url)) {
      setState(() {
        errorText = '⚠️ URL de YouTube no válida';
        message = '';
      });
      return;
    }

    final videoData = {
      'titulo': _titleController.text.trim(),
      'descripcion': _descriptionController.text.trim(),
      'texto': _textController.text.trim(),
      'url': url,
      'timestamp': Timestamp.now(),
    };

    await FirebaseFirestore.instance.collection('videos').add(videoData);

    setState(() {
      message = '✅ Video subido con éxito';
      errorText = null;
      _videoId = null;
    });

    _titleController.clear();
    _descriptionController.clear();
    _textController.clear();
    _urlController.clear();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _textController.dispose();
    _urlController.dispose();
    super.dispose();
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
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Texto adicional'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'URL de YouTube',
                errorText: errorText,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _updateVideoPreview,
                  tooltip: 'Actualizar vista previa',
                ),
              ),
              onChanged: (value) {
                // Opcional: actualizar preview automáticamente
                // _updateVideoPreview();
              },
            ),
            const SizedBox(height: 20),
            if (_videoId != null)
              YoutubeVideoPlayerExample(videoId: _videoId!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Subir Video'),
            ),
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Pantalla Videos para mostrar la lista con reproductor integrado
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
                      YoutubeVideoPlayerExample(videoId: videoId)
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
