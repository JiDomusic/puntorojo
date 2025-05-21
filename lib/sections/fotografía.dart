import 'package:flutter/material.dart';

class Fotos extends StatelessWidget {
  const Fotos({super.key});

  final List<Map<String, String>> items = const [
    {
      'image': 'assets/images/ejemplo1.jpg',
      'title': 'Evento Cultural',
      'description': 'Celebramos la diversidad con una noche de música y danza.'
    },
    {
      'image': 'assets/images/ejemplo2.jpg',
      'title': 'Arte Urbano',
      'description': 'Muralistas locales transformaron nuestro barrio con color.'
    },
    {
      'image': 'assets/images/ejemplo3.jpg',
      'title': 'Taller Comunitario',
      'description': 'Jornada de aprendizaje en oficios creativos para jóvenes.'
    },
    {
      'image': 'assets/images/ejemplo4.jpg',
      'title': 'Noche de Cine',
      'description': 'Cine comunitario al aire libre, bajo las estrellas.'
    },
    {
      'image': 'assets/images/ejemplo5.jpg',
      'title': 'Feria Local',
      'description': 'Expositores locales compartieron arte, comida y cultura.'
    },
    {
      'image': 'assets/images/ejemplo6.jpg',
      'title': 'Música en Vivo',
      'description': 'Bandas emergentes llenaron la plaza de energía y ritmo.'
    },
    {
      'image': 'assets/images/puntorojo2.jpg',
      'title': 'Pintura Colectiva',
      'description': 'Una gran obra colaborativa hecha por vecinos del barrio.'
    },
    {
      'image': 'assets/images/ejemplo8.jpg',
      'title': 'Festival de Sabores',
      'description': 'Comida de distintas culturas servida por la comunidad.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Galería Punto Rojo'),
        backgroundColor: Colors.red.shade900,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 800;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Momentos Especiales',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'los mejores momentos de nuestras actividades comunitarias.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    isWide
                        ? Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: items
                          .map((item) => SizedBox(
                        width: 350,
                        child: AnimatedImageCard(
                          imagePath: item['image']!,
                          title: item['title']!,
                          description: item['description']!,
                        ),
                      ))
                          .toList(),
                    )
                        : Column(
                      children: items
                          .map((item) => AnimatedImageCard(
                        imagePath: item['image']!,
                        title: item['title']!,
                        description: item['description']!,
                      ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedImageCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;

  const AnimatedImageCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  State<AnimatedImageCard> createState() => _AnimatedImageCardState();
}

class _AnimatedImageCardState extends State<AnimatedImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.6),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
