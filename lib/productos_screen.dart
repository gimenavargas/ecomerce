import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'producto.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  Future<List<Producto>> _getProductos() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore.collection('Productos').get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Producto.fromMap(data);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos Registrados')),
      body: FutureBuilder<List<Producto>>(
        future: _getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los productos.'));
          }

          final productos = snapshot.data;

          if (productos == null || productos.isEmpty) {
            return const Center(child: Text('No hay productos disponibles.'));
          }

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(producto.name),
                  subtitle: Text(
                    'Categoría: ${producto.category}\n'
                    'Descripción: ${producto.description}\n'
                    'Precio: \$${producto.price.toStringAsFixed(2)}\n'
                    'Stock: ${producto.stock}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
