import 'package:flutter/material.dart';

import 'package:inventario_app_finish/domain/entities/inventory.dart';

class InventoryListItem extends StatelessWidget {
  final Inventory inventory;
  final VoidCallback onTap;

  InventoryListItem({required this.inventory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(inventory.name),
      subtitle: Text(inventory.description),
      trailing: Text('Cantidad: ${inventory.quantity}'),
      onTap: onTap,
    );
  }
}
