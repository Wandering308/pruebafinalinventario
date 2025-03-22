import '../entities/product.dart';
import '../repositories/inventory_repository.dart';

class UpdateProduct {
  final InventoryRepository repository;

  UpdateProduct(this.repository);

  Future<void> call(Product product) async {
    return await repository.updateProduct(product);
  }
}
