import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper';

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
    required this.getInventories,
    required this.getProducts,
    required this.addInventory,
    required this.addProduct,
    required this.deleteInventory,
    required this.deleteProduct,
    required this.updateInventory,
    required this.updateProduct,
  }) : super(InventoryInitial());

  Stream<InventoryState> mapEventToState(InventoryEvent event) async* {
    // Implementación de eventos a estados
  }
}
