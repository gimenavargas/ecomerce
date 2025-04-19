import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'producto.dart';
import 'producto_detalle_screen.dart';
import 'package:provider/provider.dart';
import 'carrito_provider.dart';
import 'carrito_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:firebase_auth/firebase_auth.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  Future<List<Producto>> _getProductos() async {
    final snapshot = await FirebaseFirestore.instance.collection('Productos').get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Producto.fromMap(data);
    }).toList();
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1000) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final carritoProvider = Provider.of<CarritoProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF2B223C), // fondo mágico profundo
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF5D3A9B), // púrpura encantado
        elevation: 8,
        title: Text(
          'Tienda Mística',
          style: GoogleFonts.medievalSharp(
            textStyle: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFD6FF), // rosa mágico
              shadows: [
                Shadow(color: Colors.black87, blurRadius: 6, offset: Offset(2, 2)),
              ],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login'); // o la ruta que corresponda
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Producto>>(
            future: _getProductos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFFE0A9F0)));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay productos mágicos disponibles.',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              final productos = snapshot.data!;

              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(top: 80, left: 12, right: 12, bottom: 80),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: productos.length,
                        itemBuilder: (context, index) {
                          final producto = productos[index];

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3B2F63), Color(0xFF6B3FA0)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 8,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          producto.image,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.broken_image, size: 60, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            producto.name,
                                            style: GoogleFonts.medievalSharp(
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFFFD6FF),
                                              ),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'S/ ${producto.price.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              color: Color(0xFFFF8FC2),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Stock: ${producto.stock}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProductoDetalleScreen(producto: producto),
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFFBA68C8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  shadowColor: Colors.white,
                                                ),
                                                child: Text(
                                                  'Ver Más',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  carritoProvider.agregarProducto(producto);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('${producto.name} agregado al carrito'),
                                                      backgroundColor: const Color(0xFFCE93D8),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(Icons.shopping_cart, size: 16),
                                                label: const Text('Agregar al carrito'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFFE91E63),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
                },
              );
            },
          ),

          // Botón de agregar producto (esquina superior izquierda)
          Positioned(
            top: 20,
            left: 16,
            child: FloatingActionButton(
              heroTag: 'btnAgregar',
              onPressed: () {
                Navigator.pushNamed(context, '/agregarProducto');
              },
              backgroundColor: const Color(0xFFFF8FC2),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),

      // Carrito como burbuja flotante
      floatingActionButton: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: 1.1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: carritoProvider.productos.isNotEmpty ? value : 0,
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -8, end: -8),
              showBadge: carritoProvider.productos.isNotEmpty,
              badgeStyle: badges.BadgeStyle(
                badgeColor: const Color(0xFFFFC1E3),
                elevation: 4,
              ),
              badgeContent: Text(
                carritoProvider.productos.length.toString(),
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              ),
              child: FloatingActionButton(
                heroTag: 'btnCarrito',
                backgroundColor: const Color(0xFF7B1FA2),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CarritoScreen()),
                  );
                },
                child: const Icon(Icons.shopping_cart, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
