import 'package:flutter/material.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper.dart';
import 'package:inventario_app_finish/presentation/pages/add_product_page.dart';
import 'package:inventario_app_finish/presentation/pages/edit_product_page.dart';

class ProductListPage extends StatefulWidget {
  final String inventoryId;

  ProductListPage({required this.inventoryId});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Product> productList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshProductList();
  }

  Future<void> _refreshProductList() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Get products from the specific inventory
      var products =
          await databaseHelper.getProductsByInventoryId(widget.inventoryId);

      setState(() {
        productList = products;
        isLoading = false;
      });

      print(
          'Refreshed ${products.length} products for inventory ${widget.inventoryId}');
    } catch (e) {
      print('Error refreshing products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos del Inventario'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : productList.isEmpty
              ? Center(child: Text('No hay productos en este inventario'))
              : RefreshIndicator(
                  onRefresh: _refreshProductList,
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(productList[index].name),
                          subtitle: Text(
                              'Cantidad: ${productList[index].quantity} | Precio: \$${productList[index].price.toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProductPage(
                                        product: productList[index],
                                      ),
                                    ),
                                  );
                                  if (result == true) {
                                    await _refreshProductList();
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteConfirmation(
                                      productList[index].id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddProductPage(inventoryId: widget.inventoryId),
            ),
          );

          if (result == true) {
            await _refreshProductList();
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showDeleteConfirmation(String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar Producto'),
          content: Text('¿Estás seguro de que deseas eliminar este producto?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                Navigator.of(context).pop();

                try {
                  // Call deleteProduct with the product ID
                  await databaseHelper.deleteProduct(productId);

                  // Refresh the list after deletion
                  await _refreshProductList();

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Producto eliminado con éxito')));
                } catch (e) {
                  print('Error deleting product: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al eliminar el producto')));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
