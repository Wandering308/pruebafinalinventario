import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper.dart';

import 'package:inventario_app_finish/infrastructure/datasources/local_storage_impl.dart';
import 'package:inventario_app_finish/presentation/widgets/product_list_item.dart';

class InventoryDetailPage extends StatelessWidget {
  final String inventoryId;

  const InventoryDetailPage({super.key, required this.inventoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Inventario'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Lógica para borrar el inventario
              BlocProvider.of<InventoryBloc>(context)
                  .add(DeleteInventoryEvent(inventoryId));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => InventoryBloc(
          localStorage:
              LocalStorageImpl(), // Asegúrate de usar la implementación correcta
          getInventories:
              GetInventories(DatabaseHelper() as InventoryRepository),
          getProducts: GetProducts(DatabaseHelper() as InventoryRepository),
          addInventory: AddInventory(DatabaseHelper() as InventoryRepository),
          addProduct: AddProduct(DatabaseHelper() as InventoryRepository),
          deleteInventory:
              DeleteInventory(DatabaseHelper() as InventoryRepository),
          deleteProduct: DeleteProduct(DatabaseHelper() as InventoryRepository),
          updateInventory:
              UpdateInventory(DatabaseHelper() as InventoryRepository),
          updateProduct: UpdateProduct(DatabaseHelper() as InventoryRepository),
          databaseHelper: DatabaseHelper() as InventoryRepository,
        )..add(LoadProducts(inventoryId)),
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            if (state is InventoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is InventoryLoaded) {
              final products = state.products;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductListItem(
                          product: product,
                          onDelete: () {
                            // Lógica para borrar el producto
                            BlocProvider.of<InventoryBloc>(context).add(
                                DeleteProductEvent(product.id, inventoryId));
                          },
                        );
                      },
                    ),
                  ),
                  if (products.isEmpty)
                    Center(child: Text('No hay productos disponibles')),
                ],
              );
            } else if (state is InventoryError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No hay productos disponibles'));
            }
          },
        ),
      ),
    );
  }
}
