import '../entities/product.dart';
import '../repositories/inventory_repository.dart';

/// Caso de uso para obtener la lista de productos de un inventario específico.
class GetProducts {
  final InventoryRepository repository;

  /// Constructor que recibe el repositorio como dependencia.
  GetProducts(this.repository);

  /// Llama al repositorio para obtener la lista de productos de un inventario.
  ///
  /// [inventoryId]: El ID del inventario del cual se obtendrán los productos.
  Future<List<Product>> call(String inventoryId) async {
    return await repository.getProducts(inventoryId);
  }
}
