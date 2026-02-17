import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restoapp/domain/entities/cart_item.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/domain/entities/restaurant_table.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartSetTable>(_onSetTable);
    on<CartAddItem>(_onAddItem);
    on<CartUpdateQuantity>(_onUpdateQuantity);
    on<CartUpdateNotes>(_onUpdateNotes);
    on<CartRemoveItem>(_onRemoveItem);
    on<CartClear>(_onClear);
  }

  void _onSetTable(CartSetTable event, Emitter<CartState> emit) {
    emit(state.copyWith(selectedTable: event.table));
  }

  void _onAddItem(CartAddItem event, Emitter<CartState> emit) {
    final existingIndex = state.items.indexWhere(
      (item) => item.menuId == event.menu.id,
    );

    List<CartItem> updatedItems;

    if (existingIndex >= 0) {
      // Update existing item quantity
      final existingItem = state.items[existingIndex];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + event.quantity,
      );
      updatedItems = List.from(state.items);
      updatedItems[existingIndex] = updatedItem;
    } else {
      // Add new item
      final newItem = CartItem(
        menuId: event.menu.id,
        menuName: event.menu.name,
        price: event.menu.price,
        quantity: event.quantity,
        imageUrl: event.menu.imageUrl,
      );
      updatedItems = [...state.items, newItem];
    }

    emit(state.copyWith(items: updatedItems));
  }

  void _onUpdateQuantity(CartUpdateQuantity event, Emitter<CartState> emit) {
    if (event.quantity <= 0) {
      // Remove item if quantity is 0 or less
      add(CartRemoveItem(menuId: event.menuId));
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.menuId == event.menuId) {
        return item.copyWith(quantity: event.quantity);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }

  void _onUpdateNotes(CartUpdateNotes event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.menuId == event.menuId) {
        return item.copyWith(specialNotes: event.notes);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }

  void _onRemoveItem(CartRemoveItem event, Emitter<CartState> emit) {
    final updatedItems = state.items
        .where((item) => item.menuId != event.menuId)
        .toList();

    emit(state.copyWith(items: updatedItems));
  }

  void _onClear(CartClear event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}
