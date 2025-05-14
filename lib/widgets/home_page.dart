import 'package:flutter/material.dart';
import 'package:puntorojo/widgets/side_section.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Navigator.pushNamed(context, '/admin'),
        child: const Icon(Icons.lock_outline),
      ),
      body: Row(
        children: const [
          Expanded(
            child: SideSection(
              isLeft: true,
              logoPath: 'assets/images/Punto Rojo_Redes_Identidad_Perfil_01.jpg',
              sectionId: 'cooperativa',
            ),
          ),
          VerticalDivider(width: 1, color: Colors.grey),
          Expanded(
            child: SideSection(
              isLeft: false,
              logoPath: 'assets/images/logo_right.png',
              sectionId: 'audiovisual',
            ),
          ),
        ],
      ),
    );
  }
}
