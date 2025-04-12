class Producto {
  final String name;
  final String category;
  final String description;
  final int id;
  final double price;
  final int stock;

  Producto({
    required this.name,
    required this.category,
    required this.description,
    required this.id,
    required this.price,
    required this.stock,
  });

  factory Producto.fromMap(Map<String, dynamic> data) {
    return Producto(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      id: data['id'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
      stock: data['stock'] ?? 0,
    );
  }
}
