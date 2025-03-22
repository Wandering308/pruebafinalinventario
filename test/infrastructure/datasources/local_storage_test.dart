import 'package:flutter_test/flutter_test.dart';

import 'package:inventario_app_finish/domain/entities/inventory.dart';
import 'package:inventario_app_finish/infrastructure/datasources/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // ignore: unused_local_variable
  late LocalStorage localStorage;
  // ignore: unused_local_variable
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage();
  });

  final tInventory = Inventory(id: '1', name: 'Inventario 1');

  test('should save and load inventories', () async {
    // arrange
    final inventories = [tInventory];

    // act
    await LocalStorage.saveInventories(inventories);
    final result = await LocalStorage.loadInventories();

    // assert
    expect(result, inventories);
  });
}
