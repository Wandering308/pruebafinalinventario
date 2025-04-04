import 'package:flutter/material.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({required this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController barcodeController;
  late TextEditingController categoryController;
  late TextEditingController brandController;
  bool _isLoading = false;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    quantityController =
        TextEditingController(text: widget.product.quantity.toString());
    priceController =
        TextEditingController(text: widget.product.price.toString());
    barcodeController = TextEditingController(text: widget.product.barcode);
    categoryController = TextEditingController(text: widget.product.category);
    brandController = TextEditingController(text: widget.product.brand);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre del Producto',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa el nombre del producto';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        labelText: 'Cantidad',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa la cantidad';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Por favor ingresa un número válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Precio',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa el precio';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Por favor ingresa un número válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: barcodeController,
                      decoration: InputDecoration(
                        labelText: 'Código de Barras',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Categoría',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: brandController,
                      decoration: InputDecoration(
                        labelText: 'Marca',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _updateProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: Text(
                        'Actualizar Producto',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Create updated product object with the same inventoryId as the original product
        Product updatedProduct = Product(
          id: widget.product.id,
          name: nameController.text,
          quantity: int.parse(quantityController.text),
          price: double.parse(priceController.text),
          inventoryId:
              widget.product.inventoryId, // Preserve the original inventoryId
          barcode: barcodeController.text,
          category: categoryController.text,
          brand: brandController.text,
        );

        // Update the product in the database
        await databaseHelper.updateProduct(updatedProduct);

        setState(() {
          _isLoading = false;
        });

        // Return true to indicate success
        Navigator.pop(context, true);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print('Error updating product: $e');
        _showErrorDialog('Error al actualizar el producto: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    priceController.dispose();
    barcodeController.dispose();
    categoryController.dispose();
    brandController.dispose();
    super.dispose();
  }
}
