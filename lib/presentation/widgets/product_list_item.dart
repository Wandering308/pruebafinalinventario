import 'package:flutter/material.dart';

import 'package:inventario_app_finish/domain/entities/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  ProductListItem({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Precio: \$${product.price.toStringAsFixed(2)}'),
      trailing: Text('Cantidad: ${product.quantity}'),
      onTap: onTap,
    );
  }
}
