import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market/home_screen.dart';
import 'package:market/auth/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar Sesión")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: "Correo")),
            TextField(controller: password, decoration: const InputDecoration(labelText: "Contraseña"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );

                  // Navegar a HomeScreen
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                } on FirebaseAuthException catch (e) {
                  String errorMessage = '';
                  if (e.code == 'user-not-found') {
                    errorMessage = 'No se encontró un usuario con ese correo.';
                  } else if (e.code == 'wrong-password') {
                    errorMessage = 'Contraseña incorrecta.';
                  } else {
                    errorMessage = 'Error al iniciar sesión. Por favor, intente nuevamente.';
                  }
                  _showErrorDialog(context, errorMessage);
                } catch (e) {
                  _showErrorDialog(context, 'Ocurrió un error inesperado. Por favor, inténtelo de nuevo.');
                }
              },
              child: const Text("Ingresar"),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RegisterScreen(isAdmin: false)),
              ),
              child: const Text("Registrarse como Usuario"),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RegisterScreen(isAdmin: true)),
              ),
              child: const Text("Registrarse como Administrador"),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }
}
