import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

/// Caso de uso para obtener la lista de inventarios.
class GetInventories {
  final InventoryRepository repository;

  /// Constructor que recibe el repositorio como dependencia.
  GetInventories(this.repository);

  /// Llama al repositorio para obtener la lista de inventarios.
  Future<List<Inventory>> call() async {
    return await repository.getInventories();
  }
}
