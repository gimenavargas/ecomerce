import 'package:flutter/material.dart';
import 'producto.dart';

class CarritoProvider with ChangeNotifier {
  // Lista privada de productos en el carrito
  final List<Producto> _items = [];

  // Getter para acceder a la lista de productos en el carrito
  List<Producto> get items => _items;

  // Método para agregar un producto al carrito
  void agregarProducto(Producto producto) {
    _items.add(producto);
    notifyListeners();
  }

  // Método para eliminar un producto del carrito
  void eliminarProducto(Producto producto) {
    _items.remove(producto);
    notifyListeners();
  }

  // Método para vaciar el carrito
  void vaciarCarrito() {
    _items.clear();
    notifyListeners();
  }

  // Calcular el total del carrito
  double get total {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  // Obtener la cantidad total de productos en el carrito
  int get cantidad => _items.length;
}
