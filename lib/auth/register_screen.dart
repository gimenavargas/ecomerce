import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final bool isAdmin;

  RegisterScreen({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
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
                  // Crear usuario en Firebase Auth
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );

                  // Guardamos el rol en Firestore
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userCredential.user!.uid)
                      .set({'email': email.text, 'role': isAdmin ? 'admin' : 'usuario'});

                  // Navegar de vuelta al login
                  Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  String errorMessage = '';
                  if (e.code == 'email-already-in-use') {
                    errorMessage = 'El correo ya está registrado. Por favor, intente con otro.';
                  } else if (e.code == 'weak-password') {
                    errorMessage = 'La contraseña es demasiado débil.';
                  } else {
                    errorMessage = 'Error al registrar. Por favor, intente nuevamente.';
                  }
                  _showErrorDialog(context, errorMessage);
                } catch (e) {
                  _showErrorDialog(context, 'Ocurrió un error inesperado. Por favor, inténtelo de nuevo.');
                }
              },
              child: Text("Registrar ${isAdmin ? 'Administrador' : 'Usuario'}"),
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
