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
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'inventario.db');

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
  Future<void> insertInventory(Inventory inventory) async {
    final db = await database;
    await db.insert('inventories', inventory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Inventory>> getInventories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('inventories');
    return List.generate(maps.length, (i) {
      return Inventory.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Product>> getProducts(String inventoryId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'inventoryId = ?',
      whereArgs: [inventoryId],
    );
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  @override
  Future<void> updateInventory(Inventory inventory) async {
    final db = await database;
    await db.update(
      'inventories',
      inventory.toMap(),
      where: 'id = ?',
      whereArgs: [inventory.id],
    );
  }

  @override
  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  @override
  Future<void> deleteInventory(String id) async {
    final db = await database;
    await db.delete(
      'inventories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteProduct(String id, String inventoryId) async {
    final db = await database;
    await db.delete(
      'products',
      where: 'id = ? AND inventoryId = ?',
      whereArgs: [id, inventoryId],
    );
  }

  Future<void> addInventory(Inventory inventory) async {
    await insertInventory(inventory);
  }

  Future<void> addProduct(Product product) async {
    await insertProduct(product);
  }
}
