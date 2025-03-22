import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../domain/entities/inventory.dart';
import '../../domain/entities/product.dart';

class LocalStorage {
  static const String _inventoriesKey = 'inventories';
  static const String _productsKey = 'products';

  static Future<void> saveInventories(List<Inventory> inventories) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(inventories.map((e) => e.toJson()).toList());
    await prefs.setString(_inventoriesKey, json);
  }

  static Future<List<Inventory>> loadInventories() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_inventoriesKey);
    if (json != null) {
      final List<dynamic> data = jsonDecode(json);
      return data.map((e) => Inventory.fromJson(e)).toList();
    }
    return [];
  }

  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(products.map((e) => e.toJson()).toList());
    await prefs.setString(_productsKey, json);
  }

  static Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_productsKey);
    if (json != null) {
      final List<dynamic> data = jsonDecode(json);
      return data.map((e) => Product.fromJson(e)).toList();
    }
    return [];
  }
}
