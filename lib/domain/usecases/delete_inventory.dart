import '../repositories/inventory_repository.dart';

class DeleteInventory {
  final InventoryRepository repository;

  DeleteInventory(this.repository);

  Future<void> call(String inventoryId) async {
    return await repository.deleteInventory(inventoryId);
  }
}
