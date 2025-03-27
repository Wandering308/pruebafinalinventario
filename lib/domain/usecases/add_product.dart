import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';

class AddProduct {
  final InventoryRepository repository;

  AddProduct(this.repository);

  Future<void> call(Product product) async {
    await repository.insertProduct(product);
  }
}
