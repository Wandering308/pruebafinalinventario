import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/presentation/pages/product_list_page.dart';
import 'package:inventario_app_finish/presentation/widgets/inventory_list_item.dart';

class InventoryListPage extends StatefulWidget {
  const InventoryListPage({super.key});

  @override
  State<InventoryListPage> createState() => _InventoryListPageState();
}

class _InventoryListPageState extends State<InventoryListPage> {
  @override
  void initState() {
    super.initState();
    // Ensure inventories are loaded when the page is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InventoryBloc>().add(LoadInventories());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventarios'),
      ),
      body: BlocConsumer<InventoryBloc, InventoryState>(
        listener: (context, state) {
          // Show snackbar on errors or successful operations
          if (state is InventoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is InventoryDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Inventario eliminado con éxito')),
            );
            // Reload the inventory list after deletion
            context.read<InventoryBloc>().add(LoadInventories());
          }
        },
        builder: (context, state) {
          if (state is InventoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is InventoryLoaded) {
            if (state.inventories.isEmpty) {
              return Center(child: Text('No hay inventarios disponibles'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<InventoryBloc>().add(LoadInventories());
              },
              child: ListView.builder(
                itemCount: state.inventories.length,
                itemBuilder: (context, index) {
                  final inventory = state.inventories[index];
                  return InventoryListItem(
                    inventory: inventory,
                    onTap: () async {
                      // Navigate to product list page and wait for result
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListPage(
                            inventoryId: inventory.id,
                          ),
                        ),
                      );

                      // Reload inventories when returning
                      if (mounted) {
                        context.read<InventoryBloc>().add(LoadInventories());
                      }
                    },
                    onDelete: () {
                      _showDeleteConfirmationDialog(context, inventory.id);
                    },
                    onLongPress: () {
                      _showDeleteConfirmationDialog(context, inventory.id);
                    },
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('No hay inventarios disponibles'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to add inventory page and wait for result
          final result = await Navigator.pushNamed(context, '/add_inventory');
          // Reload inventories when returning, regardless of result
          if (result == true) {
            context.read<InventoryBloc>().add(LoadInventories());
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String inventoryId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Eliminar Inventario'),
          content: Text(
              '¿Estás seguro de que deseas eliminar este inventario? Esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context
                    .read<InventoryBloc>()
                    .add(DeleteInventoryEvent(inventoryId));
              },
            ),
          ],
        );
      },
    );
  }
}
