import 'package:flutter/material.dart';

class SideSection extends StatelessWidget {
  final bool isLeft;
  final String logoPath;
  final String sectionId;

  const SideSection({
    super.key,
    required this.isLeft,
    required this.logoPath,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = isLeft ? Alignment.topLeft : Alignment.topRight;

    return Container(
      color: isLeft ? Colors.teal.shade50 : Colors.blue.shade50,
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              logoPath,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: alignment,
            child: Column(
              crossAxisAlignment:
              isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 40),
                _navButton(context, 'Inicio', '/inicio'),
                _navButton(context, 'Nosotros', '/nosotros'),
                _navButton(context, 'Servicios', '/servicios'),
                if (!isLeft) _navButton(context, 'Audiovisual', '/audiovisual'),
                _navButton(context, 'Contacto', '/contacto'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
