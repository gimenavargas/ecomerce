import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
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
                label: const Text('Guardar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D4EDD),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
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
          fillColor: const Color(0xFF0F3460),
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
