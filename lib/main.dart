import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // Para eliminar el "#" de las URLs en web

Future<void> main() async {
  usePathUrlStrategy(); // solo si es web, opcional pero recomendable
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCy1ebHorTaRBgIm4GzicdtDsIbsnKuTYE",
      authDomain: "puntorojo-9a6ce.firebaseapp.com",
      projectId: "puntorojo-9a6ce",
      messagingSenderId: "826307552004",
      appId: "1:826307552004:web:075cf163a2436cfaa82651",
    ),
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Pública',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[900],
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateTo(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SubMenuScreen(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedButton(BuildContext context, String label, VoidCallback onTap) {
      return _AnimatedElevatedButton(label: label, onTap: onTap);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset('images/puntorojo.jpg',
                              width: 150, height: 150),
                        ),
                        const SizedBox(height: 20),
                        const Text('Punto Rojo',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 20),
                        animatedButton(context, 'Nosotros', () => _navigateTo(context, 'Nosotros')),
                        animatedButton(context, 'Historia', () => _navigateTo(context, 'Historia')),
                        animatedButton(context, 'Contacto', () => _navigateTo(context, 'Contacto')),
                        animatedButton(context, 'Audiovisuales', () => _navigateTo(context, 'Audiovisuales')),
                        animatedButton(context, 'Fotos', () => _navigateTo(context, 'Fotos')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset('images/coopinga.png',
                              width: 150, height: 150),
                        ),
                        const SizedBox(height: 20),
                        const Text('Cooperativa Inga',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 20),
                        animatedButton(context, 'Cooperativa', () => _navigateTo(context, 'Cooperativa')),
                        animatedButton(context, 'Quienes Somos', () => _navigateTo(context, 'Quienes Somos')),
                        animatedButton(context, 'Contacto', () => _navigateTo(context, 'Contacto')),
                        animatedButton(context, 'Servicios', () => _navigateTo(context, 'Servicios')),
                        animatedButton(context, 'Videos', () => _navigateTo(context, 'Videos')),
                        animatedButton(context, 'Fotos', () => _navigateTo(context, 'Fotos')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _AnimatedElevatedButton(
              label: 'Videos',
              icon: Icons.video_library,
              onTap: () => _navigateTo(context, 'Videos'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedElevatedButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const _AnimatedElevatedButton({
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  State<_AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<_AnimatedElevatedButton> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _pressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _pressed = false;
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final elevation = _pressed ? 12.0 : 4.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: Offset(0, elevation / 2),
                blurRadius: elevation,
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white),
                const SizedBox(width: 8),
              ],
              Text(widget.label,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class SubMenuScreen extends StatelessWidget {
  final String title;

  const SubMenuScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Sección: $title',
          style: const TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }
}
