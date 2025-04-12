import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'producto.dart';

class ProductoDetalleScreen extends StatelessWidget {
  final Producto producto;

  const ProductoDetalleScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Fondo oscuro
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F3460),
        elevation: 4,
        title: Text(
          producto.name,
          style: GoogleFonts.medievalSharp(
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.amberAccent,
              shadows: [
                Shadow(color: Colors.black, blurRadius: 4, offset: Offset(1, 1)),
              ],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0F3460).withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 4,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.amberAccent.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: isLargeScreen ? 280 : 200,
                  height: isLargeScreen ? 280 : 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF533483), Color(0xFF0F3460)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amberAccent.withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 2,
                        offset: const Offset(4, 4),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      producto.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildDetails(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          producto.name,
          style: GoogleFonts.medievalSharp(
            textStyle: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Categoría: ${producto.category}',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          producto.description,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        Divider(color: Colors.white30, thickness: 1),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.price_check, color: Colors.greenAccent),
            const SizedBox(width: 8),
            Text(
              'S/ ${producto.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontSize: 18, color: Colors.greenAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory, color: Colors.lightBlueAccent),
            const SizedBox(width: 8),
            Text(
              'Stock: ${producto.stock}',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
