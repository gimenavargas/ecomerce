import 'package:flutter/material.dart';
import 'producto.dart';

class ProductoDetalleScreen extends StatelessWidget {
  final Producto producto;

  const ProductoDetalleScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: Text(producto.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Container(
                width: isLargeScreen ? 250 : 180, // Ajuste en tamaño de contenedor
                height: isLargeScreen ? 250 : 180, // Ajuste en tamaño de contenedor
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    producto.image,
                    fit: BoxFit.cover, // Ajuste de la imagen
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(producto.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Categoría: ${producto.category}', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text(producto.description, style: const TextStyle(fontSize: 16), textAlign: TextAlign.justify),
        const SizedBox(height: 20),
        Text('Precio: S/ ${producto.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, color: Colors.green)),
        Text('Stock: ${producto.stock}', style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
