import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';

abstract class LocalStorage {
  Future<List<Inventory>> loadInventories();
  Future<void> saveInventories(List<Inventory> inventories);
  Future<List<Product>> loadProducts();
  Future<void> saveProducts(List<Product> products);
}
