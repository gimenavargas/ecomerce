import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'productos_screen.dart';
import 'agregar_producto_screen.dart';
import 'carrito_screen.dart'; // Asegúrate de tener esta pantalla
import 'carrito_provider.dart'; // Asegúrate de tener este provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        ChangeNotifierProvider(create: (_) => CarritoProvider()),
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
      initialRoute: '/',
      routes: {
        '/': (context) => const ProductosScreen(),
        '/agregarProducto': (context) => const AgregarProductoScreen(),
        '/carrito': (context) => const CarritoScreen(),
      },
    );
  }
}
