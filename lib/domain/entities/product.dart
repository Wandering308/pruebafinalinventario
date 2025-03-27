class Product {
  final String id;
  final String inventoryId;
  final String name;
  final String? barcode;
  final double price;
  final int quantity;
  final String? category;
  final String? brand;

  Product({
    required this.id,
    required this.inventoryId,
    required this.name,
    this.barcode,
    required this.price,
    required this.quantity,
    this.category,
    this.brand,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      inventoryId: map['inventoryId'],
      name: map['name'],
      barcode: map['barcode'],
      price: map['price'],
      quantity: map['quantity'],
      category: map['category'],
      brand: map['brand'],
    );
  }

  Map<String, dynamic> toMap() {
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

  static Map<String, dynamic> toJson(Product product) {
    return {
      'id': product.id,
      'inventoryId': product.inventoryId,
      'name': product.name,
      'barcode': product.barcode,
      'price': product.price,
      'quantity': product.quantity,
      'category': product.category,
      'brand': product.brand,
    };
  }
}
