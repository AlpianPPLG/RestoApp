part of 'menu_bloc.dart';

/// Base class for all menu events.
abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all menus and categories.
class MenuLoadAll extends MenuEvent {
  const MenuLoadAll();
}

/// Event to load menus filtered by category.
class MenuLoadByCategory extends MenuEvent {
  final int categoryId;

  const MenuLoadByCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

/// Event to create a new menu.
class MenuCreate extends MenuEvent {
  final Menu menu;

  const MenuCreate(this.menu);

  @override
  List<Object?> get props => [menu];
}

/// Event to update an existing menu.
class MenuUpdate extends MenuEvent {
  final Menu menu;

  const MenuUpdate(this.menu);

  @override
  List<Object?> get props => [menu];
}

/// Event to toggle menu active status.
class MenuToggleStatus extends MenuEvent {
  final int menuId;
  final bool isActive;

  const MenuToggleStatus({required this.menuId, required this.isActive});

  @override
  List<Object?> get props => [menuId, isActive];
}

/// Event to delete a menu.
class MenuDelete extends MenuEvent {
  final int menuId;

  const MenuDelete(this.menuId);

  @override
  List<Object?> get props => [menuId];
}

/// Event to search menus.
class MenuSearch extends MenuEvent {
  final String query;

  const MenuSearch(this.query);

  @override
  List<Object?> get props => [query];
}
