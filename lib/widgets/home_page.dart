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
              logoPath: 'images/coopinga.png',
              sectionId: 'cooperativa',
            ),
          ),
          VerticalDivider(width: 1, color: Colors.grey),
          Expanded(
            child: SideSection(
              isLeft: false,
              logoPath: 'images/puntorojo.jpg',
              sectionId: 'audiovisual',
            ),
          ),
        ],
      ),
    );
  }
}
