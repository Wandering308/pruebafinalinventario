import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';

abstract class InventoryRepository {
  Future<List<Inventory>> getInventories();
  Future<List<Product>> getProducts(String inventoryId);
  Future<void> addInventory(Inventory inventory);
  Future<void> addProduct(Product product);
  Future<void> updateInventory(Inventory inventory);
  Future<void> updateProduct(Product product);
  Future<void> deleteInventory(String inventoryId);
  Future<void> deleteProduct(String productId, String inventoryId);
}
