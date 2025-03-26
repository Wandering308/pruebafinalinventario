import 'package:equatable/equatable.dart';

class Inventory extends Equatable {
  final String id;
  final String name;
  final String? description;

  Inventory({
    required this.id,
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}
