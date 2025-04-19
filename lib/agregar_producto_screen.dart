import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'listar_productos_screen.dart';  // Importa la pantalla para listar productos

class AgregarProductoScreen extends StatefulWidget {
  const AgregarProductoScreen({super.key});

  @override
  State<AgregarProductoScreen> createState() => _AgregarProductoScreenState();
}

class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _imagenController = TextEditingController();

  void _guardarProducto() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('Productos').add({
        'name': _nombreController.text,
        'price': double.tryParse(_precioController.text) ?? 0.0,
        'stock': int.tryParse(_stockController.text) ?? 0,
        'description': _descripcionController.text,
        'category': _categoriaController.text,
        'image': _imagenController.text,
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.greenAccent),
                SizedBox(width: 12),
                Expanded(child: Text('Producto guardado con éxito 🎉')),
              ],
            ),
            backgroundColor: const Color(0xFF0F3460),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }

      await Future.delayed(const Duration(milliseconds: 300));
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: Text(
          'Agregar Producto',
          style: GoogleFonts.medievalSharp(
            textStyle: const TextStyle(color: Colors.amberAccent),
          ),
        ),
        backgroundColor: const Color(0xFF0F3460),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F3460).withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.amberAccent.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 4,
              )
            ],
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildTextField('Nombre del producto', _nombreController),
                _buildTextField('Precio', _precioController, tipo: TextInputType.number),
                _buildTextField('Stock', _stockController, tipo: TextInputType.number),
                _buildTextField('Categoría', _categoriaController),
                _buildTextField('Descripción', _descripcionController, maxLines: 3),
                _buildTextField('URL de la imagen', _imagenController),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _guardarProducto,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar Producto'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9D4EDD),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ListarProductosScreen()),
                    );
                  },
                  icon: const Icon(Icons.list),
                  label: const Text('Ver Productos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9D4EDD),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType tipo = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.amberAccent),
          filled: true,
          fillColor: const Color(0xFF16213E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Este campo es obligatorio';
          return null;
        },
      ),
    );
  }
}
