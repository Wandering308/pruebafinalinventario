import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';

class AddInventory {
  final InventoryRepository repository;

  AddInventory(this.repository);

  Future<void> call(Inventory inventory) async {
    await repository.insertInventory(inventory);
  }
}
