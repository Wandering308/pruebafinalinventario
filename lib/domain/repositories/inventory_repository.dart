import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';

abstract class InventoryRepository {
  Future<void> insertInventory(Inventory inventory);
  Future<void> insertProduct(Product product);
  Future<List<Inventory>> getInventories();
  Future<List<Product>> getProducts(String inventoryId);
  Future<void> updateInventory(Inventory inventory);
  Future<void> updateProduct(Product product);
  Future<void> deleteInventory(String id);
  Future<void> deleteProduct(String id, String inventoryId);
}
