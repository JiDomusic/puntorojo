import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class contacto extends StatefulWidget {
  const contacto({super.key});

  @override
  State<contacto> createState() => _contactoState();
}

class _contactoState extends State<contacto> {
  late GoogleMapController mapController;

  final LatLng puntoRojoLocation = const LatLng(-32.9518, -60.6661); // Rosario, ejemplo

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Función para lanzar urls (tel, mail, whatsapp, web)
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir: $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacto Punto Rojo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contacto y Consultas',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Para consultas o información, podés comunicarte con nosotros a través de los siguientes medios:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),

            // Gmail
            ContactItem(
              icon: Icons.email,
              color: Colors.red,
              title: 'Correo Electrónico',
              subtitle: 'puntorojo.rosario@gmail.com',
              onTap: () => _launchUrl('mailto:puntorojo.rosario@gmail.com'),
            ),
            const SizedBox(height: 20),

            // Instagram
            ContactItem(
              icon: Icons.camera_alt_outlined, // icono por defecto Material para Instagram
              color: Colors.purple,
              title: 'Instagram',
              subtitle: '@puntorojo.rosario',
              onTap: () => _launchUrl('https://www.instagram.com/puntorojo.rosario'),
            ),
            const SizedBox(height: 20),

            // Teléfono
            ContactItem(
              icon: Icons.phone,
              color: Colors.green,
              title: 'Teléfono',
              subtitle: '+54 341 123 4567',
              onTap: () => _launchUrl('tel:+543411234567'),
            ),
            const SizedBox(height: 20),

            // WhatsApp usando font_awesome_flutter
            ContactItem(
              iconData: FontAwesomeIcons.whatsapp,
              color: Colors.greenAccent.shade700,
              title: 'WhatsApp',
              subtitle: '+54 9 341 987 6543',
              onTap: () => _launchUrl('https://wa.me/5493419876543'),
            ),

            const SizedBox(height: 40),

            const Text(
              'Ubicación en Rosario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: puntoRojoLocation,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('puntoRojo'),
                    position: puntoRojoLocation,
                    infoWindow: const InfoWindow(title: 'Punto Rojo'),
                  )
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData? icon; // Para íconos Material normales
  final IconData? iconData; // Para FontAwesomeIcons
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ContactItem({
    super.key,
    this.icon,
    this.iconData,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : assert(icon != null || iconData != null);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    if (iconData != null) {
      iconWidget = FaIcon(iconData, size: 28, color: Colors.white);
    } else {
      iconWidget = Icon(icon, size: 28, color: Colors.white);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(0, 4),
              blurRadius: 6,
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 24,
              child: iconWidget,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.white70)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }
}
