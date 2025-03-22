import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';

abstract class InventoryEvent {}

class LoadInventories extends InventoryEvent {}

class LoadProducts extends InventoryEvent {
  final String inventoryId;
  LoadProducts(this.inventoryId);
}

class AddInventoryEvent extends InventoryEvent {
  final Inventory inventory;
  AddInventoryEvent(this.inventory);
}

class AddProductEvent extends InventoryEvent {
  final Product product;
  AddProductEvent(this.product);
}

class UpdateInventoryEvent extends InventoryEvent {
  final Inventory inventory;
  UpdateInventoryEvent(this.inventory);
}

class UpdateProductEvent extends InventoryEvent {
  final Product product;
  UpdateProductEvent(this.product);
}

class DeleteInventoryEvent extends InventoryEvent {
  final String inventoryId;
  DeleteInventoryEvent(this.inventoryId);
}

class DeleteProductEvent extends InventoryEvent {
  final String productId;
  DeleteProductEvent(this.productId);
}
