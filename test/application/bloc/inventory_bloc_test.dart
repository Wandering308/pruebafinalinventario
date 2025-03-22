import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:inventario_app_finish/application/bloc/inventory_bloc.dart';
import 'package:inventario_app_finish/application/bloc/inventory_event.dart';
import 'package:inventario_app_finish/application/bloc/inventory_state.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/entities/product.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';
import 'package:inventario_app_finish/domain/usecases/add_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/add_product.dart';
import 'package:inventario_app_finish/domain/usecases/delete_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/delete_product.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:inventario_app_finish/domain/usecases/get_products.dart';
import 'package:inventario_app_finish/domain/usecases/update_inventory.dart';
import 'package:inventario_app_finish/domain/usecases/update_product.dart';

import 'package:mockito/mockito.dart';

class MockInventoryRepository extends Mock implements InventoryRepository {}

void main() {
  late InventoryBloc inventoryBloc;
  late MockInventoryRepository mockInventoryRepository;

  setUp(() {
    mockInventoryRepository = MockInventoryRepository();
    inventoryBloc = InventoryBloc(
      getInventories: GetInventories(mockInventoryRepository),
      getProducts: GetProducts(mockInventoryRepository),
      addInventory: AddInventory(mockInventoryRepository),
      addProduct: AddProduct(mockInventoryRepository),
      updateInventory: UpdateInventory(mockInventoryRepository),
      updateProduct: UpdateProduct(mockInventoryRepository),
      deleteInventory: DeleteInventory(mockInventoryRepository),
      deleteProduct: DeleteProduct(mockInventoryRepository),
    );
  });

  group('InventoryBloc', () {
    final inventory = Inventory(id: '1', name: 'Inventario 1');
    final product = Product(
      id: '1',
      inventoryId: '1',
      name: 'Producto 1',
      barcode: '1234567890123',
      price: 59.99,
      quantity: 10,
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [InventoryLoading, InventoryLoaded] when LoadInventories is added',
      build: () {
        when(
          mockInventoryRepository.getInventories(),
        ).thenAnswer((_) async => [inventory]);
        return inventoryBloc;
      },
      act: (bloc) => bloc.add(LoadInventories()),
      expect: () => [
        InventoryLoading(),
        InventoryLoaded([inventory], []),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [InventoryLoading, InventoryError] when LoadInventories fails',
      build: () {
        when(
          mockInventoryRepository.getInventories(),
        ).thenThrow(Exception('Error'));
        return inventoryBloc;
      },
      act: (bloc) => bloc.add(LoadInventories()),
      expect: () => [
        InventoryLoading(),
        InventoryError('Error al cargar los inventarios'),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [InventoryLoading, InventoryLoaded] when LoadProducts is added',
      build: () {
        when(
          mockInventoryRepository.getProducts('1'),
        ).thenAnswer((_) async => [product]);
        return inventoryBloc;
      },
      act: (bloc) => bloc.add(LoadProducts('1')),
      expect: () => [
        InventoryLoading(),
        InventoryLoaded([], [product]),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [InventoryLoading, InventoryError] when LoadProducts fails',
      build: () {
        when(
          mockInventoryRepository.getProducts('1'),
        ).thenThrow(Exception('Error'));
        return inventoryBloc;
      },
      act: (bloc) => bloc.add(LoadProducts('1')),
      expect: () => [
        InventoryLoading(),
        InventoryError('Error al cargar los productos'),
      ],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [InventoryAdded] when AddInventoryEvent is added',
      build: () {
        when(
          mockInventoryRepository.addInventory(inventory),
        ).thenAnswer((_) async {});
        return inventoryBloc;
      },
      act: (bloc) => bloc.add(AddInventoryEvent(inventory)),
      expect: () => [InventoryAdded()],
    );

    blocTest<InventoryBloc, InventoryState>(
      'emits [ProductAdded] when AddProductEvent is added',
      build: () {
        when(
          mockInventoryRepository.addProduct(product),
        ).thenAnswer((_) async {});
        return inventoryBloc;
      },
      act: (bloc) => bloc.add(AddProductEvent(product)),
      expect: () => [ProductAdded()],
    );
  });
}
