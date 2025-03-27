import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final LocalStorage localStorage;

  InventoryRepositoryImpl(this.localStorage);

  @override
  Future<List<Inventory>> getInventories() async {
    return await localStorage.loadInventories();
  }

  @override
  Future<List<Product>> getProducts(String inventoryId) async {
    final products = await localStorage.loadProducts();
    return products
        .where((product) => product.inventoryId == inventoryId)
        .toList();
  }

  @override
  Future<void> addInventory(Inventory inventory) async {
    final inventories = await localStorage.loadInventories();
    inventories.add(inventory);
    await localStorage.saveInventories(inventories);
  }

  @override
  Future<void> addProduct(Product product) async {
    final products = await localStorage.loadProducts();
    products.add(product);
    await localStorage.saveProducts(products);
  }

  @override
  Future<void> updateInventory(Inventory inventory) async {
    final inventories = await localStorage.loadInventories();
    final index = inventories.indexWhere((inv) => inv.id == inventory.id);
    if (index != -1) {
      inventories[index] = inventory;
      await localStorage.saveInventories(inventories);
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    final products = await localStorage.loadProducts();
    final index = products.indexWhere((prod) => prod.id == product.id);
    if (index != -1) {
      products[index] = product;
      await localStorage.saveProducts(products);
    }
  }

  @override
  Future<void> deleteInventory(String inventoryId) async {
    final inventories = await localStorage.loadInventories();
    inventories.removeWhere((inv) => inv.id == inventoryId);
    await localStorage.saveInventories(inventories);
  }

  @override
  Future<void> deleteProduct(String inventoryId, String productId) async {
    final products = await localStorage.loadProducts();
    products.removeWhere(
        (prod) => prod.inventoryId == inventoryId && prod.id == productId);
    await localStorage.saveProducts(products);
  }
}
