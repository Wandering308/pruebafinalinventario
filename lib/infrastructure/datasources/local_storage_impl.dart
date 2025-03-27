import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  @override
  Future<List<Inventory>> loadInventories() async {
    final prefs = await SharedPreferences.getInstance();
    final inventoryJsonList = prefs.getStringList('inventories') ?? [];
    return inventoryJsonList
        .map((jsonString) => Inventory.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  @override
  Future<void> saveInventories(List<Inventory> inventories) async {
    final prefs = await SharedPreferences.getInstance();
    final inventoryJsonList = inventories
        .map((inventory) => jsonEncode(Inventory.toJson(inventory)))
        .toList();
    await prefs.setStringList('inventories', inventoryJsonList);
  }

  @override
  Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productJsonList = prefs.getStringList('products') ?? [];
    return productJsonList
        .map((jsonString) => Product.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  @override
  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productJsonList =
        products.map((product) => jsonEncode(Product.toJson(product))).toList();
    await prefs.setStringList('products', productJsonList);
  }
}
