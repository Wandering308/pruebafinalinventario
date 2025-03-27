import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';

import 'package:inventario_app_finish/injection.dart';
import 'package:inventario_app_finish/presentation/pages/add_inventory_page.dart';
import 'package:inventario_app_finish/presentation/pages/inventory_list_page.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar databaseFactory para plataformas que no sean móviles
  if (isDesktopOrWeb()) {
    sqfliteFfiInit();
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      databaseFactory = databaseFactoryFfi;
    }
  }

  await setupLocator();

  runApp(MyApp());
}

bool isDesktopOrWeb() {
  return (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      kIsWeb);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<InventoryBloc>()..add(LoadInventories()),
        ),
      ],
      child: MaterialApp(
        title: 'Inventario App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InventoryListPage(),
        routes: {
          '/add_inventory': (context) => AddInventoryPage(),
        },
      ),
    );
  }
}
