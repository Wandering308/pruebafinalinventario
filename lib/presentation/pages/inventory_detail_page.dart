import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';

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
      body: BlocBuilder<InventoryBloc, InventoryState>(
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
                      return ListTile(
                        title: Text(product.name),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Lógica para borrar el producto
                            BlocProvider.of<InventoryBloc>(context).add(
                                DeleteProductEvent(product.id, inventoryId));
                          },
                        ),
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
    );
  }
}
