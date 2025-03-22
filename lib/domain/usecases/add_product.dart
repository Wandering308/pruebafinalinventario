import '../entities/product.dart';
import '../repositories/inventory_repository.dart';

class AddProduct {
  final InventoryRepository repository;

  AddProduct(this.repository);

  Future<void> call(Product product) async {
    return await repository.addProduct(product);
  }
}
