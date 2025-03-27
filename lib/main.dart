import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage_impl.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';
import 'package:inventario_app_finish/presentation/pages/add_inventory_page.dart';
import 'package:inventario_app_finish/presentation/pages/inventory_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InventoryBloc(
            databaseHelper: DatabaseHelper(),
            localStorage: LocalStorageImpl(),
            getInventories: GetInventories(DatabaseHelper()),
            getProducts: GetProducts(DatabaseHelper()),
            addInventory: AddInventory(DatabaseHelper()),
            addProduct: AddProduct(DatabaseHelper()),
            deleteInventory: DeleteInventory(DatabaseHelper()),
            deleteProduct: DeleteProduct(DatabaseHelper()),
            updateInventory: UpdateInventory(DatabaseHelper()),
            updateProduct: UpdateProduct(DatabaseHelper()),
          )..add(LoadInventories()),
        ),
      ],
      child: MaterialApp(
        title: 'Inventario App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InventoryListPage(),
        routes: {
          '/add_inventory': (context) => AddInventoryPage(),
        },
      ),
    );
  }
}
