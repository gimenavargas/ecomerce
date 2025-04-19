import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'carrito_provider.dart';
import 'FormularioCompra.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        backgroundColor: const Color(0xFF0F3460),
      ),
      body: carrito.items.isEmpty
          ? const Center(
              child: Text('Tu carrito está vacío.', style: TextStyle(color: Colors.white70)),
            )
          : ListView.builder(
              itemCount: carrito.items.length,
              itemBuilder: (context, index) {
                final producto = carrito.items[index];
                return ListTile(
                  leading: Image.network(producto.image, width: 50),
                  title: Text(producto.name, style: const TextStyle(color: Colors.white)),
                  subtitle: Text('S/ ${producto.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => carrito.eliminarProducto(producto),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF16213E),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total: S/ ${carrito.total.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FormularioCompra()),
    );
  },
  child: const Text('Realizar compra'),
),

          ],
        ),
      ),
      backgroundColor: const Color(0xFF1A1A2E),
    );
  }
}
