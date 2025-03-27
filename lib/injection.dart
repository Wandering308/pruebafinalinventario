import 'package:get_it/get_it.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';
import 'package:inventario_app_finish/infrastructure/datasources/database_helper.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage_impl.dart';
import 'package:inventario_app_finish/infrastructure/repositories/inventory_repository_impl.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Datasources
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorageImpl());
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Repositories
  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(getIt<LocalStorage>()),
  );

  // Use Cases
  getIt.registerLazySingleton(
      () => GetInventories(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => GetProducts(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => AddInventory(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => AddProduct(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(
      () => DeleteInventory(getIt<InventoryRepository>()));
  getIt
      .registerLazySingleton(() => DeleteProduct(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(
      () => UpdateInventory(getIt<InventoryRepository>()));
  getIt
      .registerLazySingleton(() => UpdateProduct(getIt<InventoryRepository>()));

  // Bloc
  getIt.registerLazySingleton(() => InventoryBloc(
        databaseHelper: getIt<DatabaseHelper>(),
        localStorage: getIt<LocalStorage>(),
        getInventories: getIt<GetInventories>(),
        getProducts: getIt<GetProducts>(),
        addInventory: getIt<AddInventory>(),
        addProduct: getIt<AddProduct>(),
        deleteInventory: getIt<DeleteInventory>(),
        deleteProduct: getIt<DeleteProduct>(),
        updateInventory: getIt<UpdateInventory>(),
        updateProduct: getIt<UpdateProduct>(),
      ));
}
