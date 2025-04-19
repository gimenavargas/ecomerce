import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppSender {
  static Future<void> enviarPDFporWhatsApp(File pdfFile) async {
    final url = Uri.parse(
        "https://wa.me/949782440?text=Hola, adjunto la boleta de mi compra."); // cambia el número

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir WhatsApp';
    }

    // Nota: No puedes adjuntar archivos directamente desde url_launcher.
    // Para eso se necesita integrar una API backend o usar WhatsApp Business API.
  }
}
