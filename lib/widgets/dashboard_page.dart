import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sections = [
      {
        'title': 'Inicio',
        'icon': Icons.home,
        'route': '/inicio',
      },
      {
        'title': 'Nosotros',
        'icon': Icons.info,
        'route': '/nosotros',
      },
      {
        'title': 'Servicios',
        'icon': Icons.miscellaneous_services,
        'route': '/servicios',
      },
      {
        'title': 'Audiovisual',
        'icon': Icons.video_library,
        'route': '/audiovisual',
      },
      {
        'title': 'Contacto',
        'icon': Icons.contact_mail,
        'route': '/contacto',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: sections.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final section = sections[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, section['route'] as String),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.teal.shade100,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        section['icon'] as IconData,
                        size: 40,
                        color: Colors.teal.shade800,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        section['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
