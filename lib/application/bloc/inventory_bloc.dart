import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';

import 'inventory_event.dart';
import 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetInventories getInventories;
  final GetProducts getProducts;
  final AddInventory addInventory;
  final AddProduct addProduct;
  final UpdateInventory updateInventory;
  final UpdateProduct updateProduct;
  final DeleteInventory deleteInventory;
  final DeleteProduct deleteProduct;

  InventoryBloc({
    required this.getInventories,
    required this.getProducts,
    required this.addInventory,
    required this.addProduct,
    required this.updateInventory,
    required this.updateProduct,
    required this.deleteInventory,
    required this.deleteProduct,
  }) : super(InventoryInitial()) {
    on<LoadInventories>(_onLoadInventories);
    on<LoadProducts>(_onLoadProducts);
    on<AddInventoryEvent>(_onAddInventory);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateInventoryEvent>(_onUpdateInventory);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteInventoryEvent>(_onDeleteInventory);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  void _onLoadInventories(
    LoadInventories event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoading());
    try {
      final inventories = await getInventories();
      emit(InventoryLoaded(inventories, []));
    } catch (e) {
      emit(InventoryError('Error al cargar los inventarios'));
    }
  }

  void _onLoadProducts(LoadProducts event, Emitter<InventoryState> emit) async {
    emit(InventoryLoading());
    try {
      final products = await getProducts(event.inventoryId);
      emit(InventoryLoaded([], products));
    } catch (e) {
      emit(InventoryError('Error al cargar los productos'));
    }
  }

  void _onAddInventory(
    AddInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await addInventory(event.inventory);
      emit(InventoryAdded());
    } catch (e) {
      emit(InventoryError('Error al agregar el inventario'));
    }
  }

  void _onAddProduct(
    AddProductEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await addProduct(event.product);
      emit(ProductAdded());
    } catch (e) {
      emit(InventoryError('Error al agregar el producto'));
    }
  }

  void _onUpdateInventory(
    UpdateInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await updateInventory(event.inventory);
      emit(InventoryUpdated());
    } catch (e) {
      emit(InventoryError('Error al actualizar el inventario'));
    }
  }

  void _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await updateProduct(event.product);
      emit(ProductUpdated());
    } catch (e) {
      emit(InventoryError('Error al actualizar el producto'));
    }
  }

  void _onDeleteInventory(
    DeleteInventoryEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await deleteInventory(event.inventoryId);
      emit(InventoryDeleted());
    } catch (e) {
      emit(InventoryError('Error al eliminar el inventario'));
    }
  }

  void _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      await deleteProduct(event.productId);
      emit(ProductDeleted());
    } catch (e) {
      emit(InventoryError('Error al eliminar el producto'));
    }
  }
}
