import 'package:flutter/material.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem(
      {super.key, required this.product, required Null Function() onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Código de barras: ${product.barcode ?? ''}'),
      trailing: Text('Precio: \$${product.price}'),
    );
  }
}
