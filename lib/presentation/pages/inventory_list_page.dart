import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/presentation/pages/add_inventory_page.dart';
import 'package:inventario_app_finish/presentation/pages/product_list_page.dart'; // Importar la página de productos
import 'package:inventario_app_finish/presentation/widgets/inventory_list_item.dart';

class InventoryListPage extends StatelessWidget {
  const InventoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // El BlocProvider debería estar fuera del MaterialPageRoute
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddInventoryPage(),
                ),
              ).then((_) {
                // Recargar inventarios al regresar a la pantalla principal
                context.read<InventoryBloc>().add(LoadInventories());
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is InventoryLoaded) {
            return ListView.builder(
              itemCount: state.inventories.length,
              itemBuilder: (context, index) {
                final inventory = state.inventories[index];
                return InventoryListItem(
                  inventory: inventory,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListPage(
                            inventoryId: inventory
                                .id), // Navegar a la página de productos
                      ),
                    ).then((_) {
                      // Recargar inventarios al regresar a la pantalla principal
                      context.read<InventoryBloc>().add(LoadInventories());
                    });
                  },
                );
              },
            );
          } else if (state is InventoryError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No hay inventarios disponibles'));
          }
        },
      ),
    );
  }
}
