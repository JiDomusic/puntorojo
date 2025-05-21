import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // ✨ Requiere paquete flutter_animate
import 'quienes_somos.dart'; // Asegurate de importar correctamente

class Cooperativa extends StatefulWidget {
  const Cooperativa({super.key});

  @override
  State<Cooperativa> createState() => _CooperativaState();
}

class _CooperativaState extends State<Cooperativa>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideIn;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideIn = Tween<Offset>(
      begin: const Offset(0, 0.3),
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Bienvenidos'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🌈 Fondo animado tipo gradiente
          AnimatedContainer(
            duration: const Duration(seconds: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8E0E00),
                  Color(0xFFFFA500),
                  Color(0xFF8E0E00),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🌀 Logo animado tipo rebote y glow
                  Hero(
                    tag: 'logo-coop',
                    child: Image.asset(
                      'assets/images/coopinga.png',
                      width: 200,
                      height: 200,
                    )
                        .animate()
                        .scale(
                        delay: 200.ms,
                        duration: 800.ms,
                        curve: Curves.elasticOut)
                        .shimmer(duration: 2000.ms, color: Colors.white)
                        .then(delay: 2.seconds)
                        .shake(hz: 1, curve: Curves.easeOutCubic),
                  ),
                  const SizedBox(height: 40),
                  // ✨ Título animado con rebote y fade
                  Text(
                    '¡Bienvenidos a Cooperativa Inga!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms)
                      .slideY(begin: 0.3, duration: 800.ms)
                      .then(delay: 1.seconds)
                      .scaleXY(end: 1.02, curve: Curves.easeInOut, duration: 600.ms),
                  const SizedBox(height: 20),
                  // 🌟 Texto descriptivo con efecto de typing / reveal
                  Text(
                    'Un espacio colectivo, creativo y solidario.\n'
                        'Te invitamos a recorrer nuestras secciones, disfrutar el arte, '
                        'conectar con la comunidad y ser parte de este proyecto que crece con vos.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.yellowAccent,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3),
                  const SizedBox(height: 40),
                  // 🚀 Botón con animación
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.explore),
                    label: const Text(
                      'Explorar la Cooperativa',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const QuienesSomos(),
                        ),
                      );
                    },
                  )
                      .animate()
                      .fadeIn(delay: 1.seconds)
                      .slideY(begin: 0.3)
                      .scaleXY(end: 1.05, curve: Curves.easeOutBack),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
