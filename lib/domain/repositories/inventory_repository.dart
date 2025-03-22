import '../entities/inventory.dart';
import '../entities/product.dart';

/// Interfaz que define las operaciones que el repositorio debe implementar.
abstract class InventoryRepository {
  /// Obtiene la lista de inventarios.
  Future<List<Inventory>> getInventories();

  /// Obtiene la lista de productos de un inventario específico.
  Future<List<Product>> getProducts(String inventoryId);
}
