import 'package:flutter/material.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddInventoryPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  AddInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Inventario')),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newInventory = Inventory(
                      id: DateTime.now().toString(), // Genera un ID único
                      name: _nameController.text,
                      description: '', // Añade una descripción si es necesario
                    );
                    context.read<InventoryBloc>().add(
                          AddInventoryEvent(newInventory),
                        );
                    Navigator.pop(context, true); // Devuelve true al volver
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
