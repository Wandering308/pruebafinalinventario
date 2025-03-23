import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';

abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<Inventory> inventories;
  final List<Product> products;

  InventoryLoaded(this.inventories, this.products);
}

class InventoryError extends InventoryState {
  final String message;

  InventoryError(this.message);
}
