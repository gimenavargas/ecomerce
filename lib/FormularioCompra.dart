import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'carrito_provider.dart';
import 'pdf_generator.dart';
import 'whatsapp_sender.dart';

class FormularioCompra extends StatefulWidget {
  @override
  _FormularioCompraState createState() => _FormularioCompraState();
}

class _FormularioCompraState extends State<FormularioCompra> {
  final _formKey = GlobalKey<FormState>();
  String? _nombre, _dni, _direccion, _telefono;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario de Compra")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Por favor ingresa tu nombre' : null,
                onSaved: (value) => _nombre = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'DNI/RUC'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Por favor ingresa tu DNI/RUC' : null,
                onSaved: (value) => _dni = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Por favor ingresa tu dirección' : null,
                onSaved: (value) => _direccion = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Por favor ingresa tu teléfono' : null,
                onSaved: (value) => _telefono = value,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Obtener productos del carrito
                      final carritoProvider = Provider.of<CarritoProvider>(context, listen: false);
                      final carrito = carritoProvider.items
                          .map((producto) => {
                                'nombre': producto.name,
                                'precio': producto.price,
                                'descripcion': producto.description,
                              })
                          .toList();

                      // Generar PDF y enviar por WhatsApp
                      PdfGenerator().generarBoleta(
                        nombre: _nombre!,
                        dni: _dni!,
                        direccion: _direccion!,
                        telefono: _telefono!,
                        productos: carrito,
                      ).then((pdfFile) {
                        WhatsAppSender.enviarPDFporWhatsApp(pdfFile);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Compra realizada exitosamente')),
                      );
                    }
                  },
                  child: const Text('Generar Boleta y Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
