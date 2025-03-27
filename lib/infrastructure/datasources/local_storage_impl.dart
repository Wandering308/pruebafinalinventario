import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  static const String _inventoryKey = 'inventories';
  static const String _productKey = 'products';

  @override
  Future<List<Inventory>> loadInventories() async {
    final prefs = await SharedPreferences.getInstance();
    final inventoryData = prefs.getString(_inventoryKey) ?? '[]';
    final List<dynamic> jsonData = jsonDecode(inventoryData);
    return jsonData.map((item) => Inventory.fromMap(item)).toList();
  }

  @override
  Future<void> saveInventories(List<Inventory> inventories) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonData =
        inventories.map((inv) => inv.toMap()).toList();
    prefs.setString(_inventoryKey, jsonEncode(jsonData));
  }

  @override
  Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productData = prefs.getString(_productKey) ?? '[]';
    final List<dynamic> jsonData = jsonDecode(productData);
    return jsonData.map((item) => Product.fromMap(item)).toList();
  }

  @override
  Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonData =
        products.map((prod) => prod.toMap()).toList();
    prefs.setString(_productKey, jsonEncode(jsonData));
  }
}
