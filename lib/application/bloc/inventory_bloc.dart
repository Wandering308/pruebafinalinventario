import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper';

import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';

import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final DatabaseHelper databaseHelper;
  final LocalStorage localStorage;
  final GetInventories getInventories;
  final GetProducts getProducts;
  final AddInventory addInventory;
  final AddProduct addProduct;
  final DeleteInventory deleteInventory;
  final DeleteProduct deleteProduct;
  final UpdateInventory updateInventory;
  final UpdateProduct updateProduct;

  InventoryBloc({
    required this.databaseHelper,
    required this.localStorage,
    required this.getInventories,
    required this.getProducts,
    required this.addInventory,
    required this.addProduct,
    required this.deleteInventory,
    required this.deleteProduct,
    required this.updateInventory,
    required this.updateProduct,
  }) : super(InventoryInitial()) {
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
      final inventories = await localStorage.loadInventories();

      // Obtener el estado actual y mantener la lista de productos
      final currentState = state;
      List<Product> currentProducts = [];
      if (currentState is InventoryLoaded) {
        currentProducts = currentState.products;
      }

      emit(InventoryLoaded(inventories, currentProducts));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onLoadProducts(LoadProducts event, Emitter<InventoryState> emit) async {
    emit(InventoryLoading());
    try {
      final products = await localStorage.loadProducts();

      // Obtener el estado actual y mantener la lista de inventarios
      final currentState = state;
      List<Inventory> currentInventories = [];
      if (currentState is InventoryLoaded) {
        currentInventories = currentState.inventories;
      }

      emit(InventoryLoaded(currentInventories, products));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onAddInventory(
      AddInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      await addInventory(event.inventory);
      final inventories = await localStorage.loadInventories();
      inventories.add(event.inventory);
      await localStorage.saveInventories(inventories);
      add(LoadInventories());
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onAddProduct(
      AddProductEvent event, Emitter<InventoryState> emit) async {
    try {
      await addProduct(event.product);
      final products = await localStorage.loadProducts();
      products.add(event.product);
      await localStorage.saveProducts(products);
      add(LoadProducts(event.product.inventoryId));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onDeleteInventory(
      DeleteInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      await deleteInventory(event.inventoryId);
      final inventories = await localStorage.loadInventories();
      inventories.removeWhere((inventory) => inventory.id == event.inventoryId);
      await localStorage.saveInventories(inventories);
      add(LoadInventories());
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onDeleteProduct(
      DeleteProductEvent event, Emitter<InventoryState> emit) async {
    try {
      await deleteProduct(event.productId, event.inventoryId);
      final products = await localStorage.loadProducts();
      products.removeWhere((product) => product.id == event.productId);
      await localStorage.saveProducts(products);
      add(LoadProducts(event.inventoryId));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onUpdateInventory(
      UpdateInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      await updateInventory(event.inventory);
      final inventories = await localStorage.loadInventories();
      final index =
          inventories.indexWhere((inv) => inv.id == event.inventory.id);
      if (index != -1) {
        inventories[index] = event.inventory;
        await localStorage.saveInventories(inventories);
      }
      add(LoadInventories());
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onUpdateProduct(
      UpdateProductEvent event, Emitter<InventoryState> emit) async {
    try {
      await updateProduct(event.product);
      final products = await localStorage.loadProducts();
      final index = products.indexWhere((prod) => prod.id == event.product.id);
      if (index != -1) {
        products[index] = event.product;
        await localStorage.saveProducts(products);
      }
      add(LoadProducts(event.product.inventoryId));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }
}
