import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';

class AddInventoryPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  AddInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Inventario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final inventory = Inventory(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  description: descriptionController.text,
                  quantity: int.parse(quantityController.text),
                );

                // Enviar evento al Bloc para agregar el inventario
                context.read<InventoryBloc>().add(AddInventoryEvent(inventory));

                // Regresar a la página anterior
                Navigator.of(context).pop();
              },
              child: Text('Agregar Inventario'),
            ),
          ],
        ),
      ),
    );
  }
}
