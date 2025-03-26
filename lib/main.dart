import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/presentation/pages/inventory_list_page.dart';
import 'package:inventario_app_finish/injection.dart'; // Asegúrate de importar la configuración de inyección

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup(); // Configuración de inyección de dependencias
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<InventoryBloc>()..add(LoadInventories()),
      child: MaterialApp(
        title: 'Inventario App',
        debugShowCheckedModeBanner: false,
        home: InventoryListPage(),
      ),
    );
  }
}
