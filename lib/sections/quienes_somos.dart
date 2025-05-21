import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../main.dart';

class QuienesSomos extends StatelessWidget {
  const QuienesSomos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('¿Quiénes Somos?'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Fondo degradado suave y elegante
          AnimatedContainer(
            duration: const Duration(seconds: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Color(0xFF3B0E0E),
                  Color(0xFF6E1F1F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 100, 24, 100), // dejar espacio abajo para el botón
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título cálido y elegante
                Text(
                  'Somos Cooperativa Linga',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFF3E4), // color crema suave
                  ),
                )
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.3)
                    .then()
                    .shake(hz: 1, curve: Curves.easeOutBack),
                const SizedBox(height: 20),

                // Texto descriptivo con color beige claro
                Text(
                  'Una cooperativa que vibra con la cultura, el arte y la comunidad.\n\n'
                      'Trabajamos colectivamente para crear espacios de encuentro, formación y expresión, '
                      'donde cada voz y cada idea tiene un lugar. Nuestro objetivo es construir redes solidarias, '
                      'impulsar proyectos autogestivos y fomentar el trabajo colaborativo con alegría y compromiso.\n\n'
                      'Desde talleres hasta intervenciones urbanas, desde ferias hasta festivales, '
                      'somos una comunidad en movimiento, tejiendo futuro desde el presente.',
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Color(0xFFDCC9B8), // beige claro
                  ),
                )
                    .animate()
                    .fadeIn(duration: 1000.ms, delay: 300.ms)
                    .slideY(begin: 0.2),

                const SizedBox(height: 30),

                // Imagen con escala suave sin rotación
                Center(
                  child: Image.asset(
                    'assets/images/coopinga.png',
                    width: 200,
                    height: 200,
                  )
                      .animate()
                      .scale(delay: 500.ms, duration: 800.ms, curve: Curves.elasticOut)
                      .then(delay: 1.seconds)
                      .shimmer(color: Colors.white24),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),

          // Botón "Volver al Home" fijo abajo
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                  );
                },


                icon: const Icon(Icons.home, color: Colors.black),
                label: const Text(
                  'Volver al Home',

                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD54F), // amarillo cálido
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black54,
                ),
              )
                  .animate()
                  .fadeIn(duration: 800.ms, delay: 600.ms)
                  .slideY(begin: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
