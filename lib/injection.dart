import 'package:get_it/get_it.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';
import 'package:inventario_app_finish/infrastructure/repositories/inventory_repository_impl.dart';

final getIt = GetIt.instance;

void setup() {
  // Datasources
  getIt.registerLazySingleton(() => LocalStorage());

  // Repositories
  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(getIt<LocalStorage>()),
  );

  // Use Cases
  getIt.registerLazySingleton(
    () => GetInventories(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton(() => GetProducts(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => AddInventory(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(() => AddProduct(getIt<InventoryRepository>()));
  getIt.registerLazySingleton(
    () => UpdateInventory(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateProduct(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteInventory(getIt<InventoryRepository>()),
  );
  getIt.registerLazySingleton(
    () => DeleteProduct(getIt<InventoryRepository>()),
  );

  // Bloc
  getIt.registerFactory(
    () => InventoryBloc(
      getInventories: getIt<GetInventories>(),
      getProducts: getIt<GetProducts>(),
      addInventory: getIt<AddInventory>(),
      addProduct: getIt<AddProduct>(),
      updateInventory: getIt<UpdateInventory>(),
      updateProduct: getIt<UpdateProduct>(),
      deleteInventory: getIt<DeleteInventory>(),
      deleteProduct: getIt<DeleteProduct>(),
    ),
  );
}
