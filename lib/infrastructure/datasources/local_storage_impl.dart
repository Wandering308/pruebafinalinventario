import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  List<Inventory> _inventories = [];
  List<Product> _products = [];

  @override
  Future<List<Inventory>> loadInventories() async {
    return _inventories;
  }

  @override
  Future<void> saveInventories(List<Inventory> inventories) async {
    _inventories = inventories;
  }

  @override
  Future<List<Product>> loadProducts() async {
    return _products;
  }

  @override
  Future<void> saveProducts(List<Product> products) async {
    _products = products;
  }
}
