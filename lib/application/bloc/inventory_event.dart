import 'package:equatable/equatable.dart';
import 'package:inventario_app_finish/domain/entities/inventory.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class AddInventoryEvent extends InventoryEvent {
  final Inventory inventory;

  const AddInventoryEvent(this.inventory);

  @override
  List<Object> get props => [inventory];
}
