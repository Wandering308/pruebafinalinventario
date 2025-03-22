class Inventory {
  final String id;
  final String name;
  final String description; // Nuevo campo
  final int quantity; // Nuevo campo

  Inventory({
    required this.id,
    required this.name,
    this.description = '',
    this.quantity = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
    };
  }

  static Inventory fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
    );
  }
}
