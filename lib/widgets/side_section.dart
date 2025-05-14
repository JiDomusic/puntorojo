import 'package:flutter/material.dart';
import 'package:puntorojo/widgets/central_logo.dart';


import 'SectionContentPage.dart';

class SideSection extends StatelessWidget {
  final bool isLeft;
  final String logoPath;
  final String sectionId; // 'cooperativa' o 'audiovisual'

  const SideSection({
    super.key,
    required this.isLeft,
    required this.logoPath,
    required this.sectionId,
  });

  void _navigateTo(BuildContext context, String sectionName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SectionContentPage(
          collectionName: '${sectionName}_$sectionId', // ejemplo: 'inicio_cooperativa'
          title: '${capitalize(sectionName)} ${capitalize(sectionId)}', sectionId: '', sectionName: '',
        ),
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isLeft ? Colors.blueGrey.shade50 : Colors.white,
      child: Stack(
        children: [
          Center(child: CentralLogo(logoPath: logoPath)),
          Align(
            alignment: isLeft ? Alignment.topLeft : Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  AnimatedNavButton(
                    title: 'Inicio',
                    onTap: () => _navigateTo(context, 'inicio'),
                  ),
                  const SizedBox(height: 20),
                  AnimatedNavButton(
                    title: 'Nosotros',
                    onTap: () => _navigateTo(context, 'nosotros'),
                  ),
                  const SizedBox(height: 20),
                  AnimatedNavButton(
                    title: 'Servicios',
                    onTap: () => _navigateTo(context, 'servicios'),
                  ),
                  const SizedBox(height: 20),
                  AnimatedNavButton(
                    title: 'Audiovisual',
                    onTap: () => _navigateTo(context, 'audiovisual'),
                  ),
                  const SizedBox(height: 20),
                  AnimatedNavButton(
                    title: 'Contacto',
                    onTap: () => _navigateTo(context, 'contacto'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedNavButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const AnimatedNavButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<AnimatedNavButton> createState() => _AnimatedNavButtonState();
}

class _AnimatedNavButtonState extends State<AnimatedNavButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: isHovering ? Colors.teal.shade200 : Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isHovering
                ? [BoxShadow(color: Colors.teal.withOpacity(0.4), blurRadius: 8, offset: const Offset(2, 4))]
                : [],
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isHovering ? Colors.white : Colors.teal.shade900,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
