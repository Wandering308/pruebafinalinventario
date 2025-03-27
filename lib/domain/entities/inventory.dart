class Inventory {
  final String id;
  final String name;

  Inventory({
    required this.id,
    required this.name,
  });

  factory Inventory.fromMap(Map<String, dynamic> map) {
    return Inventory(
      id: map['id'],
      name: map['name'],
    );
  }

  get description => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
