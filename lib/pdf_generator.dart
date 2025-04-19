import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  Future<File> generarBoleta({
    required String nombre,
    required String dni,
    required String direccion,
    required String telefono,
    required List<Map<String, dynamic>> productos,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('BOLETA DE COMPRA', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 10),
            pw.Text('Nombre: $nombre'),
            pw.Text('DNI/RUC: $dni'),
            pw.Text('Dirección: $direccion'),
            pw.Text('Teléfono: $telefono'),
            pw.SizedBox(height: 20),
            pw.Text('Productos:', style: pw.TextStyle(fontSize: 18)),
            ...productos.map((producto) => pw.Text(
                  '${producto["nombre"]} - S/ ${producto["precio"]}',
                )),
            pw.SizedBox(height: 10),
            pw.Text(
              'Total: S/ ${productos.fold(0.0, (sum, item) => sum + item['precio'])}',
              style: pw.TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    ));

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/boleta_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
