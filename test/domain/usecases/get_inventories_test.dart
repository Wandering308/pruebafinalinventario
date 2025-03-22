import 'package:flutter_test/flutter_test.dart';

import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/domain/repositories/inventory_repository.dart';
import 'package:inventario_app_finish/domain/usecases/get_inventories.dart';
import 'package:mockito/mockito.dart';

class MockInventoryRepository extends Mock implements InventoryRepository {
  @override
  Future<List<Inventory>> getInventories() async {
    return [];
  }
}

void main() {
  late GetInventories usecase;
  late MockInventoryRepository mockInventoryRepository;

  setUp(() {
    mockInventoryRepository = MockInventoryRepository();
    usecase = GetInventories(mockInventoryRepository);
  });

  final tInventory = Inventory(id: '1', name: 'Inventario 1');

  test('should get inventories from the repository', () async {
    // arrange
    when(
      mockInventoryRepository.getInventories(),
    ).thenAnswer((_) async => [tInventory]);

    // act
    final result = await usecase();

    // assert
    expect(result, [tInventory]);
    verify(mockInventoryRepository.getInventories());
    verifyNoMoreInteractions(mockInventoryRepository);
  });
}
