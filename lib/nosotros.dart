import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TeamMember {
  final String name;
  final String role;
  final String imageAsset;
  final String description;
  final Color accentColor;

  TeamMember({
    required this.name,
    required this.role,
    required this.imageAsset,
    required this.description,
    required this.accentColor,
  });
}

class Nosotros extends StatefulWidget {
  const Nosotros({super.key});

  @override
  State<Nosotros> createState() => _NosotrosState();
}

class _NosotrosState extends State<Nosotros> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double _scrollOffset = 0;
  final double _parallaxFactor = 0.3;

  final List<TeamMember> teamMembers = [
    TeamMember(
      name: "Director",
      role: "Director Creativo",
      imageAsset: "assets/images/puntorojo2.jpg", // Reemplaza con tus imágenes
      description: "producciones bla bla ble  ble blandjshkajdjb.",
      accentColor: Colors.amber,
    ),
    TeamMember(
      name: "DP",
      role: "Director de Fotografía",
      imageAsset: "assets/images/puntorojo4.jpg",
      description: " compocision asjasdsambdsjd   ble bla dkajsbksjd.",
      accentColor: Colors.purple,
    ),
    TeamMember(
      name: "Editor",
      role: "Editor Senior",
      imageAsset: "assets/team3.jpg",
      description: " chu chu chu chilsdhnlskd.",
      accentColor: Colors.blue,
    ),
    TeamMember(
      name: "Sound",
      role: "Diseñador de Sonido",
      imageAsset: "assets/team4.jpg",
      description: " sarsasasa sdkjahdksajd.",
      accentColor: Colors.green,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('EL EQUIPO').animate().fadeIn(duration: 800.ms),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ).animate().slideX(begin: -1, end: 0, duration: 500.ms),
      ),
      body: Stack(
        children: [
          // Fondo animado
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_controller.value * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 1.5,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.95),
                          Colors.black,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Partículas flotantes
          ...List.generate(
            20,
                (index) => Positioned(
              left: Random().nextDouble() * size.width,
              top: Random().nextDouble() * size.height,
              child: Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ).animate(
                delay: (index * 100).ms,
              )
                  .scale(duration: 2000.ms, curve: Curves.easeInOut)
                  .then(delay: 1000.ms)
                  .fadeOut(duration: 1000.ms)
                  .then()
                  .fadeIn(duration: 1000.ms),
            ),
          ),

          // Contenido principal
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: isMobile ? 100 : 150,
                ),
              ),

              // Título
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CREADORES',
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 27,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
                      const SizedBox(height: 20),
                      Text(
                        'Somos un equipo .. sarasasasasasass',
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0, delay: 200.ms),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Grid de miembros del equipo
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 1 : 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    childAspectRatio: isMobile ? 1.2 : 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final member = teamMembers[index];
                      return _buildTeamMemberCard(member, index, isMobile);
                    },
                    childCount: teamMembers.length,
                  ),
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 40),
                  child: Column(
                    children: [
                      Text(
                        'CONTÁCTANOS PARA TU PRÓXIMO PROYECTO',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(delay: 1200.ms),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Enviar Mensaje',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ).animate().fadeIn(delay: 1400.ms),
                      const SizedBox(height: 40),
                      Text(
                        '© 2025 Estudio Audiovisual',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                      ).animate().fadeIn(delay: 1600.ms),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(TeamMember member, int index, bool isMobile) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.black,
        child: Stack(
          children: [
            // Imagen de fondo con efecto parallax
            Positioned.fill(
              child: OverflowBox(
                maxHeight: double.infinity,
                child: Transform.translate(
                  offset: Offset(0, _scrollOffset * _parallaxFactor),
                  child: Image.asset(
                    member.imageAsset,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ),

            // Overlay de color
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),

            // Contenido
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      member.role,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: member.accentColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      member.description,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: member.accentColor,
                        ),
                        Icon(
                          Icons.movie_creation_rounded,
                          color: member.accentColor,
                        ),
                        Icon(
                          Icons.music_note_rounded,
                          color: member.accentColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Efecto de borde
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: member.accentColor.withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ).animate().slideY(
        begin: 0.5,
        end: 0,
        duration: 500.ms,
        delay: (index * 200).ms,
        curve: Curves.easeOutCubic,
      ),
    );
  }
}


class Random {
  static final _random = math.Random();

  double nextDouble() => _random.nextDouble();
}
