import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _loading = false;

  // Función de Login
  Future<void> _login() async {
    setState(() {
      _loading = true;
    });

    try {
      // Iniciar sesión con correo y contraseña
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Verificar si el usuario está autenticado
      if (userCredential.user != null) {
        // Comprobar si el correo es de uno de los administradores
        if (_emailController.text == 'casaculturalinga@gmail.com' ||
            _emailController.text == 'dominguezmariajimena@gmail.com') {
          // Redirigir al Admin Dashboard
          Navigator.pushReplacementNamed(context, '/admin-dashboard');
        } else {
          // Si el correo no es un admin, mostrar un mensaje
          setState(() {
            _loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Acceso no permitido.')));
        }
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al iniciar sesión: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'Introduce tu correo',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Introduce tu contraseña',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
