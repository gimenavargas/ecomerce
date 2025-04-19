import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:market/home_screen.dart';
import 'package:market/auth/login_screen.dart';
import 'package:market/auth/register_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autenticación'),
      ),
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // Si el usuario está autenticado, redirigir a HomeScreen
              return  HomeScreen();
            } else {
              // Si el usuario no está autenticado, mostrar opciones de login o registro
              return _buildAuthOptions(context);
            }
          }
          return const Center(child: CircularProgressIndicator()); // Mientras se verifica el estado de autenticación
        },
      ),
    );
  }

  Widget _buildAuthOptions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Redirigir a la pantalla de login
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Iniciar Sesión'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Redirigir a la pantalla de registro
              Navigator.pushReplacementNamed(context, '/register');
            },
            child: const Text('Registrar Usuario'),
          ),
        ],
      ),
    );
  }
}
