import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Importar Firebase
import 'package:puntorojo/widgets/SubirContactoScreen.dart';
import 'package:puntorojo/widgets/SubirNosotrosScreen.dart';
import 'package:puntorojo/widgets/SubirProyectosScreen.dart';
import 'package:puntorojo/widgets/SubirServicioScreen.dart';
import 'package:puntorojo/widgets/SubirServicios2Screen.dart';
import 'package:puntorojo/widgets/SubirTestimoniosScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Asegurarse de que todo está inicializado antes de ejecutar la app

  await Firebase.initializeApp();  // Inicializa Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Página Principal',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(), // Pantalla principal
        '/subir-servicio': (context) => SubirServicioScreen(), // Ruta para subir servicio
        '/subir-testimonio': (context) => SubirTestimoniosScreen(), // Ruta para testimonios
        '/subir-proyecto': (context) => SubirProyectosScreen(), // Ruta para proyectos
        '/subir-contacto': (context) => SubirContactoScreen(), // Ruta para contacto
        '/subir-nosotros': (context) => SubirNosotrosScreen(), // Ruta para nosotros
        '/subir-servicios2': (context) => SubirServicios2Screen(), // Ruta para servicios 2
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Página Principal')),
      body: Row(
        children: [
          // Barra lateral izquierda (Cooperativa Inga)
          NavigationPanel(
            position: 'left',
            context: context,
          ),
          // Contenido principal (botones para navegar)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bienvenido a la Página Principal', style: TextStyle(fontSize: 24)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subir-servicio');
                  },
                  child: Text('Subir Servicio'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subir-testimonio');
                  },
                  child: Text('Subir Testimonio'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subir-proyecto');
                  },
                  child: Text('Subir Proyecto'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subir-contacto');
                  },
                  child: Text('Subir Contacto'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subir-nosotros');
                  },
                  child: Text('Subir Nosotros'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/subir-servicios2');
                  },
                  child: Text('Subir Servicios 2'),
                ),
              ],
            ),
          ),
          // Barra lateral derecha (Punto Rojo)
          NavigationPanel(
            position: 'right',
            context: context,
          ),
        ],
      ),
    );
  }
}

class NavigationPanel extends StatelessWidget {
  final String position;
  final BuildContext context;

  NavigationPanel({required this.position, required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      color: position == 'left' ? Colors.blueGrey : Colors.red, // Diferente color por cada lado
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(position == 'left' ? 'Cooperativa Inga' : 'Punto Rojo'),
            leading: Icon(Icons.home),
          ),
          ListTile(
            title: Text('Inicio'),
            onTap: () {
              Navigator.pushNamed(context, '/'); // Navegar al inicio
            },
          ),
          ListTile(
            title: Text('Servicios'),
            onTap: () {
              Navigator.pushNamed(context, '/subir-servicio');
            },
          ),
          ListTile(
            title: Text('Testimonios'),
            onTap: () {
              Navigator.pushNamed(context, '/subir-testimonio');
            },
          ),
          ListTile(
            title: Text('Proyectos Sociales'),
            onTap: () {
              Navigator.pushNamed(context, '/subir-proyecto');
            },
          ),
          ListTile(
            title: Text('Contacto'),
            onTap: () {
              Navigator.pushNamed(context, '/subir-contacto');
            },
          ),
          ListTile(
            title: Text('Nosotros'),
            onTap: () {
              Navigator.pushNamed(context, '/subir-nosotros');
            },
          ),
        ],
      ),
    );
  }
}
