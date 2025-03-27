import '../repositories/inventory_repository.dart';

class DeleteProduct {
  final InventoryRepository repository;

  DeleteProduct(this.repository);

  Future<void> call(String productId, String inventoryId) async {
    return await repository.deleteProduct(productId, inventoryId);
  }
}
