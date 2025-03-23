class Product {
  final String id;
  final String inventoryId;
  final String name;
  final String barcode;
  final double price;
  final int quantity;

  Product({
    required this.id,
    required this.inventoryId,
    required this.name,
    required this.barcode,
    required this.price,
    required this.quantity,
    required String category,
    required String brand,
  });

  String? get category => null;

  String? get brand => null;
}
