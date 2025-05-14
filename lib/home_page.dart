import 'package:flutter/material.dart';
import '../widgets/side_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => Navigator.pushNamed(context, '/admin'),
        child: const Icon(Icons.lock_outline),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // Vista móvil
            return ListView(
              children: const [
                SideSection(
                  isLeft: true,
                  logoPath: 'assets/images/logo_left.png',
                  sectionId: 'cooperativa',
                ),
                Divider(),
                SideSection(
                  isLeft: false,
                  logoPath: 'assets/images/logo_right.png',
                  sectionId: 'audiovisual',
                ),
              ],
            );
          } else {
            // Vista desktop
            return Row(
              children: const [
                Expanded(
                  child: SideSection(
                    isLeft: true,
                    logoPath: 'assets/images/logo_left.png',
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
            );
          }
        },
      ),
    );
  }
}
