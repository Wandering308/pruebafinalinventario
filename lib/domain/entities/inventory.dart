import 'package:equatable/equatable.dart';

class Inventory extends Equatable {
  final String id;
  final String name;
  final String? description;

  const Inventory({
    required this.id,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, description];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Inventory.fromMap(Map<String, dynamic> map) {
    return Inventory(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
