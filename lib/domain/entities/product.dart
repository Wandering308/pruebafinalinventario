class Product {
  final String id;
  final String inventoryId;
  final String name;
  final String barcode;
  final double price;
  final int quantity;
  final String category; // Nuevo campo
  final String brand; // Nuevo campo

  Product({
    required this.id,
    required this.inventoryId,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
    this.category = '',
    this.brand = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inventoryId': inventoryId,
      'name': name,
      'barcode': barcode,
      'price': price,
      'quantity': quantity,
      'category': category,
      'brand': brand,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      inventoryId: json['inventoryId'],
      name: json['name'],
      barcode: json['barcode'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['category'],
      brand: json['brand'],
    );
  }
}
