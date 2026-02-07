part of 'menu_bloc.dart';

/// Base class for all menu states.
abstract class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading menus.
class MenuInitial extends MenuState {
  const MenuInitial();
}

/// State when loading menu data.
class MenuLoading extends MenuState {
  const MenuLoading();
}

/// State when menus are loaded.
class MenuLoaded extends MenuState {
  final List<Menu> menus;
  final List<Category> categories;
  final int? selectedCategoryId;
  final String? searchQuery;

  const MenuLoaded({
    required this.menus,
    required this.categories,
    this.selectedCategoryId,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [
    menus,
    categories,
    selectedCategoryId,
    searchQuery,
  ];
}

/// State when a menu operation succeeds.
class MenuOperationSuccess extends MenuState {
  final String message;

  const MenuOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// State when menu loading fails.
class MenuError extends MenuState {
  final String message;

  const MenuError(this.message);

  @override
  List<Object?> get props => [message];
}
