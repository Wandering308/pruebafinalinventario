import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/presentation/pages/add_inventory_page.dart';

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
              // Pasa el InventoryBloc al navegar a AddInventoryPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<InventoryBloc>(
                        context), // Pasa el InventoryBloc
                    child: AddInventoryPage(),
                  ),
                ),
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
                return ListTile(
                  title: Text(inventory.name),
                  subtitle: Text(inventory.description),
                  trailing: Text('Cantidad: ${inventory.quantity}'),
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
