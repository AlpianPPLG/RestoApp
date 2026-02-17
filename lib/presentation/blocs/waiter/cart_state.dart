part of 'cart_bloc.dart';

class CartState extends Equatable {
  final RestaurantTable? selectedTable;
  final List<CartItem> items;

  const CartState({this.selectedTable, this.items = const []});

  CartState copyWith({RestaurantTable? selectedTable, List<CartItem>? items}) {
    return CartState(
      selectedTable: selectedTable ?? this.selectedTable,
      items: items ?? this.items,
    );
  }

  // Helper getters
  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount =>
      items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  bool get canSubmitOrder => selectedTable != null && isNotEmpty;

  @override
  List<Object?> get props => [selectedTable, items];
}
