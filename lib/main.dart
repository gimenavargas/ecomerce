import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:market/auth/login_screen.dart';
import 'package:market/auth/inicio_screen.dart';
import 'package:market/auth/register_screen.dart'; // Asegúrate de tener esta pantalla
import 'package:market/home_screen.dart';
import 'package:market/productos_screen.dart';
import 'package:market/agregar_producto_screen.dart';
import 'package:market/carrito_screen.dart';
import 'package:market/carrito_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD4bHZF3MpWngoWgRjEbcK-dRtnHJ65wpc",
      authDomain: "market-7lfkwh.firebaseapp.com",
      projectId: "market-7lfkwh",
      storageBucket: "market-7lfkwh.appspot.com",
      messagingSenderId: "618739704560",
      appId: "1:618739704560:web:5f55e94a45644367351835",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarritoProvider()), // Proveedor para el carrito de compras
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tienda Mística',
      theme: ThemeData.dark(),
      initialRoute: '/', // Cambiamos la ruta inicial
      routes: {
        '/': (context) => const ProductosScreen(), // Pantalla de inicio con botones
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/productos': (context) => const ProductosScreen(),
        '/agregarProducto': (context) => const AgregarProductoScreen(),
        '/carrito': (context) => const CarritoScreen(),
      },
    );
  }
}
