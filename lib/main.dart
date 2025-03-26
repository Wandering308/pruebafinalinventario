import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper';

import 'package:inventario_app_finish/presentation/pages/inventory_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  runApp(MyApp(databaseHelper: databaseHelper));
}

class MyApp extends StatelessWidget {
  final DatabaseHelper databaseHelper;

  const MyApp({super.key, required this.databaseHelper});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InventoryBloc(databaseHelper)..add(LoadInventories()),
      child: MaterialApp(
        title: 'Inventario App',
        debugShowCheckedModeBanner: false,
        home: InventoryListPage(),
      ),
    );
  }
}
