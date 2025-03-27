import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepository databaseHelper;
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
      final inventories = await databaseHelper.getInventories();

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
      final products = await databaseHelper.getProducts(event.inventoryId);

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
      await databaseHelper.addInventory(event.inventory);
      final inventories = await databaseHelper.getInventories();
      emit(InventoryLoaded(inventories, []));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onAddProduct(
      AddProductEvent event, Emitter<InventoryState> emit) async {
    try {
      await databaseHelper.addProduct(event.product);
      final products =
          await databaseHelper.getProducts(event.product.inventoryId);
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

  void _onDeleteInventory(
      DeleteInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      await databaseHelper.deleteInventory(event.inventoryId);
      final inventories = await databaseHelper.getInventories();
      emit(InventoryDeleted());
      emit(InventoryLoaded(inventories, []));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onDeleteProduct(
      DeleteProductEvent event, Emitter<InventoryState> emit) async {
    try {
      await databaseHelper.deleteProduct(event.productId, event.inventoryId);
      final products = await databaseHelper.getProducts(event.inventoryId);
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

  void _onUpdateInventory(
      UpdateInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      await databaseHelper.updateInventory(event.inventory);
      final inventories = await databaseHelper.getInventories();
      emit(InventoryLoaded(inventories, []));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void _onUpdateProduct(
      UpdateProductEvent event, Emitter<InventoryState> emit) async {
    try {
      await databaseHelper.updateProduct(event.product);
      final products =
          await databaseHelper.getProducts(event.product.inventoryId);
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
}

class InventoryDeleted extends InventoryState {}
