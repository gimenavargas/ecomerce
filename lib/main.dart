import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'productos_screen.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProductosScreen(),
    );
  }
}
