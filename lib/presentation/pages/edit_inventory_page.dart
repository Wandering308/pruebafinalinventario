import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';

class EditInventoryPage extends StatelessWidget {
  final Inventory inventory;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();

  EditInventoryPage({required this.inventory}) {
    _nameController.text = inventory.name;
    _descriptionController.text = inventory.description;
    _quantityController.text = inventory.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Inventario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una cantidad';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedInventory = Inventory(
                      id: inventory.id,
                      name: _nameController.text,
                      description: _descriptionController.text,
                      quantity: int.parse(_quantityController.text),
                    );
                    context.read<InventoryBloc>().add(
                          UpdateInventoryEvent(updatedInventory),
                        );
                    Navigator.pop(context);
                  }
                },
                child: Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
