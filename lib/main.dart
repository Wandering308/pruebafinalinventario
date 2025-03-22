import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/injection.dart';
import 'package:inventario_app_finish/presentation/pages/inventory_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup(); // Configura la inyección de dependencias
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventario App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            getIt<InventoryBloc>(), // Proporciona el InventoryBloc
        child: InventoryListPage(),
      ),
    );
  }
}
