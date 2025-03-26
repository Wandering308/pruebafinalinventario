import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper';
import 'inventory_event.dart';
import 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final DatabaseHelper databaseHelper;

  InventoryBloc(this.databaseHelper) : super(InventoryInitial()) {
    on<LoadInventories>(_onLoadInventories);
    on<LoadProducts>(_onLoadProducts);
    on<AddInventoryEvent>(_onAddInventory);
    on<AddProductEvent>(_onAddProduct);
    on<DeleteInventoryEvent>(_onDeleteInventory);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<UpdateInventoryEvent>(_onUpdateInventory);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  void _onLoadInventories(
      LoadInventories event, Emitter<InventoryState> emit) async {
    emit(InventoryLoading());
    try {
      final inventories = await databaseHelper.getInventories();
      emit(InventoryLoaded(inventories, []));
    } catch (e) {
      emit(InventoryError('Error al cargar inventarios: $e'));
    }
  }

  void _onLoadProducts(LoadProducts event, Emitter<InventoryState> emit) async {
    emit(InventoryLoading());
    try {
      final products = await databaseHelper.getProducts(event.inventoryId);
      emit(InventoryLoaded([], products));
    } catch (e) {
      emit(InventoryError('Error al cargar productos: $e'));
    }
  }

  void _onAddInventory(
      AddInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      await databaseHelper.insertInventory(event.inventory);
      add(LoadInventories());
    } catch (e) {
      emit(InventoryError('Error al agregar inventario: $e'));
    }
  }

  void _onAddProduct(
      AddProductEvent event, Emitter<InventoryState> emit) async {
    try {
      await databaseHelper.insertProduct(event.product);
      add(LoadProducts(event.product.inventoryId));
    } catch (e) {
      emit(InventoryError('Error al agregar producto: $e'));
    }
  }

  void _onDeleteInventory(
      DeleteInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      final db = await databaseHelper.database;
      await db.delete('inventories',
          where: 'id = ?', whereArgs: [event.inventoryId]);
      await db.delete('products',
          where: 'inventoryId = ?', whereArgs: [event.inventoryId]);
      add(LoadInventories());
    } catch (e) {
      emit(InventoryError('Error al eliminar inventario: $e'));
    }
  }

  void _onDeleteProduct(
      DeleteProductEvent event, Emitter<InventoryState> emit) async {
    try {
      final db = await databaseHelper.database;
      await db
          .delete('products', where: 'id = ?', whereArgs: [event.productId]);
      add(LoadProducts(event.inventoryId));
    } catch (e) {
      emit(InventoryError('Error al eliminar producto: $e'));
    }
  }

  void _onUpdateInventory(
      UpdateInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      final db = await databaseHelper.database;
      await db.update('inventories', event.inventory.toMap(),
          where: 'id = ?', whereArgs: [event.inventory.id]);
      add(LoadInventories());
    } catch (e) {
      emit(InventoryError('Error al actualizar inventario: $e'));
    }
  }

  void _onUpdateProduct(
      UpdateProductEvent event, Emitter<InventoryState> emit) async {
    try {
      final db = await databaseHelper.database;
      await db.update('products', event.product.toMap(),
          where: 'id = ?', whereArgs: [event.product.id]);
      add(LoadProducts(event.product.inventoryId));
    } catch (e) {
      emit(InventoryError('Error al actualizar producto: $e'));
    }
  }
}
