class Inventory {
  final String id;
  final String name;
  final String? description;

  Inventory({
    required this.id,
    required this.name,
    this.description,
  });

  factory Inventory.fromMap(Map<String, dynamic> map) {
    return Inventory(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  static Inventory fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  static Map<String, dynamic> toJson(Inventory inventory) {
    return {
      'id': inventory.id,
      'name': inventory.name,
      'description': inventory.description,
    };
  }
}
