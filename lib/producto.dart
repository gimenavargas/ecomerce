class Producto {
  final String name;
  final String category;
  final String description;
  final double price;
  final int stock;
  final String image;

  Producto({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
  });

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      stock: map['stock'] ?? 0,
      image: map['image'] ?? '',
    );
  }
}
