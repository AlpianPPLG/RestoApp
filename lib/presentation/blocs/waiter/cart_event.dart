part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Set the selected table for the order
class CartSetTable extends CartEvent {
  final RestaurantTable table;

  const CartSetTable({required this.table});

  @override
  List<Object?> get props => [table];
}

/// Add menu item to cart
class CartAddItem extends CartEvent {
  final Menu menu;
  final int quantity;

  const CartAddItem({required this.menu, this.quantity = 1});

  @override
  List<Object?> get props => [menu, quantity];
}

/// Update item quantity in cart
class CartUpdateQuantity extends CartEvent {
  final int menuId;
  final int quantity;

  const CartUpdateQuantity({required this.menuId, required this.quantity});

  @override
  List<Object?> get props => [menuId, quantity];
}

/// Update special notes for item
class CartUpdateNotes extends CartEvent {
  final int menuId;
  final String? notes;

  const CartUpdateNotes({required this.menuId, this.notes});

  @override
  List<Object?> get props => [menuId, notes];
}

/// Remove item from cart
class CartRemoveItem extends CartEvent {
  final int menuId;

  const CartRemoveItem({required this.menuId});

  @override
  List<Object?> get props => [menuId];
}

/// Clear entire cart
class CartClear extends CartEvent {
  const CartClear();
}
