import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';

class DatabaseHelper implements InventoryRepository {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'inventory.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE inventories(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        inventoryId TEXT,
        name TEXT,
        barcode TEXT,
        price REAL,
        quantity INTEGER,
        category TEXT,
        brand TEXT,
        FOREIGN KEY (inventoryId) REFERENCES inventories (id)
      )
    ''');
  }

  @override
  Future<List<Inventory>> getInventories() async {
    final db = await database;
    final result = await db.query('inventories');
    return result.map((json) => Inventory.fromJson(json)).toList();
  }

  @override
  Future<List<Product>> getProducts(String inventoryId) async {
    final db = await database;
    final result = await db
        .query('products', where: 'inventoryId = ?', whereArgs: [inventoryId]);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<void> addInventory(Inventory inventory) async {
    final db = await database;
    await db.insert('inventories', Inventory.toJson(inventory));
  }

  @override
  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert('products', Product.toJson(product));
  }

  @override
  Future<void> deleteInventory(String id) async {
    final db = await database;
    await db.delete('inventories', where: 'id = ?', whereArgs: [id]);
    await db.delete('products', where: 'inventoryId = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteProduct(String productId, String inventoryId) async {
    final db = await database;
    await db.delete('products',
        where: 'id = ? AND inventoryId = ?',
        whereArgs: [productId, inventoryId]);
  }

  @override
  Future<void> updateInventory(Inventory inventory) async {
    final db = await database;
    await db.update('inventories', Inventory.toJson(inventory),
        where: 'id = ?', whereArgs: [inventory.id]);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update('products', Product.toJson(product),
        where: 'id = ?', whereArgs: [product.id]);
  }
}
