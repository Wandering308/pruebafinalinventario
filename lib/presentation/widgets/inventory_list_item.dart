import 'package:flutter/material.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';

class InventoryListItem extends StatelessWidget {
  final Inventory inventory;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onLongPress;

  const InventoryListItem({
    Key? key,
    required this.inventory,
    required this.onTap,
    required this.onDelete,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(inventory.name),
      onTap: onTap,
      onLongPress: onLongPress,
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
