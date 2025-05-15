import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NosotrosScreen extends StatefulWidget {
  const NosotrosScreen({super.key});

  @override
  State<NosotrosScreen> createState() => _NosotrosScreenState();
}

class _NosotrosScreenState extends State<NosotrosScreen>
    with TickerProviderStateMixin {
  late final AnimationController _textAnimationController;
  late final Animation<Offset> _textSlideAnimation;
  late final VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeOut,
      ),
    );
    _textAnimationController.forward();

    _videoController = VideoPlayerController.asset('assets/videos/nosotros.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedTextContainer(String text) {
    return SlideTransition(
      position: _textSlideAnimation,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoContainer() {
    return _videoController.value.isInitialized
        ? AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: VideoPlayer(_videoController),
    )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nosotros')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAnimatedTextContainer(
              'Punto Rojo es una organización que nace con el propósito de... (aquí tu texto completo sobre quienes son, misión, visión, etc.)',
            ),
            const SizedBox(height: 20),
            _buildVideoContainer(),
          ],
        ),
      ),
    );
  }
}
