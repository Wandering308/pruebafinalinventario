import 'package:equatable/equatable.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class LoadInventories extends InventoryEvent {}

class AddInventoryEvent extends InventoryEvent {
  final Inventory inventory;

  const AddInventoryEvent(this.inventory);

  @override
  List<Object> get props => [inventory];
}

class UpdateInventoryEvent extends InventoryEvent {
  final Inventory inventory;

  const UpdateInventoryEvent(this.inventory);

  @override
  List<Object> get props => [inventory];
}

class DeleteInventoryEvent extends InventoryEvent {
  final String inventoryId;

  const DeleteInventoryEvent(this.inventoryId);

  @override
  List<Object> get props => [inventoryId];
}

class LoadProducts extends InventoryEvent {
  final String inventoryId;

  const LoadProducts(this.inventoryId);

  @override
  List<Object> get props => [inventoryId];
}

class AddProductEvent extends InventoryEvent {
  final Product product;

  const AddProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends InventoryEvent {
  final Product product;

  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends InventoryEvent {
  final String productId;
  final String inventoryId;

  const DeleteProductEvent(this.productId, this.inventoryId);

  @override
  List<Object> get props => [productId, inventoryId];
}
