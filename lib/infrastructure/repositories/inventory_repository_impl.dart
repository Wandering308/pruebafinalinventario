import '../../domain/repositories/inventory_repository.dart';
import '../../domain/entities/inventory.dart';
import '../../domain/entities/product.dart';
import '../datasources/local_storage.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final LocalStorage localStorage;

  InventoryRepositoryImpl(this.localStorage);

  @override
  Future<List<Inventory>> getInventories() async {
    return await LocalStorage.loadInventories();
  }

  @override
  Future<List<Product>> getProducts(String inventoryId) async {
    final products = await LocalStorage.loadProducts();
    return products
        .where((product) => product.inventoryId == inventoryId)
        .toList();
  }

  @override
  Future<void> addInventory(Inventory inventory) async {
    final inventories = await LocalStorage.loadInventories();
    inventories.add(inventory);
    await LocalStorage.saveInventories(inventories);
  }

  @override
  Future<void> addProduct(Product product) async {
    final products = await LocalStorage.loadProducts();
    products.add(product);
    await LocalStorage.saveProducts(products);
  }

  @override
  Future<void> updateInventory(Inventory inventory) async {
    final inventories = await LocalStorage.loadInventories();
    final index = inventories.indexWhere((inv) => inv.id == inventory.id);
    if (index != -1) {
      inventories[index] = inventory;
      await LocalStorage.saveInventories(inventories);
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    final products = await LocalStorage.loadProducts();
    final index = products.indexWhere((prod) => prod.id == product.id);
    if (index != -1) {
      products[index] = product;
      await LocalStorage.saveProducts(products);
    }
  }

  @override
  Future<void> deleteInventory(String inventoryId) async {
    final inventories = await LocalStorage.loadInventories();
    inventories.removeWhere((inv) => inv.id == inventoryId);
    await LocalStorage.saveInventories(inventories);
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final products = await LocalStorage.loadProducts();
    products.removeWhere((prod) => prod.id == productId);
    await LocalStorage.saveProducts(products);
  }
}
