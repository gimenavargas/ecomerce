import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'carrito_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = Provider.of<CarritoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carrito de Compras',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF6A1B9A), // Morado oscuro
        elevation: 10,
        shadowColor: Colors.amberAccent.withOpacity(0.4),
      ),
      body: carrito.items.isEmpty
          ? const Center(
              child: Text(
                'Tu carrito está vacío.',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 189, 146, 197),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 230, 166, 240).withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 15,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: carrito.items.length,
                  itemBuilder: (context, index) {
                    final producto = carrito.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          leading: Image.network(
                            producto.image,
                            width: 50,
                          ),
                          title: Text(
                            producto.name,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                          subtitle: Text(
                            'S/ ${producto.price.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => carrito.eliminarProducto(producto),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF6A1B9A), // Morado oscuro
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total: S/ ${carrito.total.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1A1A2E),
                    title: const Text(
                      "¿Deseas continuar en WhatsApp?",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: const Text(
                      "Serás redirigido a WhatsApp para completar tu pedido.",
                      style: TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final mensaje = Uri.encodeFull(
                              "Hola, quiero realizar una compra de los siguientes productos:\n" +
                                  carrito.items
                                      .map((p) =>
                                          "- ${p.name} S/ ${p.price.toStringAsFixed(2)}")
                                      .join("\n") +
                                  "\nTotal: S/ ${carrito.total.toStringAsFixed(2)}");

                          final whatsappUrl = Uri.parse(
                              "https://wa.me/51926620412?text=$mensaje"); // Reemplaza con tu número

                          if (await canLaunchUrl(whatsappUrl)) {
                            await launchUrl(whatsappUrl,
                                mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("No se pudo abrir WhatsApp")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107), // Dorado
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Ir a WhatsApp",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 190, 112, 204), // Morado claro
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Realizar compra',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1A1A2E), // Fondo oscuro
    );
  }
}