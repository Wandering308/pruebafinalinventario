import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String inventoryId;
  final String name;
  final String? barcode;
  final int quantity;

  Product({
    required this.id,
    required this.inventoryId,
    required this.name,
    this.barcode,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, inventoryId, name, barcode, quantity];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inventoryId': inventoryId,
      'name': name,
      'barcode': barcode,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      inventoryId: map['inventoryId'],
      name: map['name'],
      barcode: map['barcode'],
      quantity: map['quantity'],
    );
  }
}
