import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

class AddInventory {
  final InventoryRepository repository;

  AddInventory(this.repository);

  Future<void> call(Inventory inventory) async {
    return await repository.addInventory(inventory);
  }
}
