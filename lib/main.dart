import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/injection.dart';
import 'package:inventario_app_finish/presentation/pages/inventory_list_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que Flutter esté inicializado
  await setup(); // Configura las dependencias con GetIt
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<InventoryBloc>(), // Proporciona el InventoryBloc a toda la app
      child: MaterialApp(
        title: 'Inventario App',
        debugShowCheckedModeBanner: false, // Oculta el banner de debug
        home: InventoryListPage(), // Página inicial
      ),
    );
  }
}
