import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:puntorojo/widgets/audiovisual_page.dart';
import 'package:puntorojo/widgets/contacto_page.dart';
import 'package:puntorojo/widgets/home_page.dart';

import 'package:puntorojo/widgets/inicio_page.dart';
import 'package:puntorojo/widgets/login_page.dart';
import 'package:puntorojo/widgets/nosotros_page.dart';
import 'package:puntorojo/widgets/servicios_page..dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casa Cultural Inga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/admin': (context) => const LoginPage(),
        '/inicio': (context) => const InicioPage(),
        '/nosotros': (context) => const NosotrosPage(),
        '/servicios': (context) => const ServiciosPage(),
        '/audiovisual': (context) => const AudiovisualPage(),
        '/contacto': (context) => const ContactoPage(),
      },
    );
  }
}
