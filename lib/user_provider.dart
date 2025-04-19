import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _role = '';
  String get role => _role;

  Future<void> fetchUserRole(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    _role = doc['role'];
    notifyListeners();
  }
}
