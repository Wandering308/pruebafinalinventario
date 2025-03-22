import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/presentation/pages/add_inventory_page.dart';
import 'package:inventario_app_finish/presentation/pages/inventory_detail_page.dart';
import 'package:inventario_app_finish/presentation/widgets/inventory_list_item.dart';

class InventoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInventoryPage()),
              );
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
                        builder: (context) =>
                            InventoryDetailPage(inventoryId: inventory.id),
                      ),
                    );
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
