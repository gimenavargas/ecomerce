import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class ListarProductosScreen extends StatelessWidget {
  const ListarProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(
          'Lista de Productos',
          style: GoogleFonts.medievalSharp(
            textStyle: const TextStyle(color: Colors.amberAccent),
          ),
        ),
        backgroundColor: const Color(0xFF0F3460),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Productos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay productos disponibles.'));
          }

          final productos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index].data() as Map<String, dynamic>;
              final nombre = producto['name'];
              final precio = producto['price'].toString();
              final stock = producto['stock'].toString();
              final categoria = producto['category'];
              final descripcion = producto['description'];

              return Card(
                color: const Color(0xFF16213E),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    nombre,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Precio: \$ $precio', style: const TextStyle(color: Colors.white)),
                      Text('Stock: $stock', style: const TextStyle(color: Colors.white)),
                      Text('Categoría: $categoria', style: const TextStyle(color: Colors.white)),
                      Text('Descripción: $descripcion', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Productos')
                          .doc(productos[index].id)
                          .delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
