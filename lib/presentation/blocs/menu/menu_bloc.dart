import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:restoapp/core/utils/logger/app_logger.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/domain/entities/category.dart';
import 'package:restoapp/domain/repositories/menu_repository.dart';

part 'menu_event.dart';
part 'menu_state.dart';

/// BLoC for managing menu data.
@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository _menuRepository;

  MenuBloc(this._menuRepository) : super(const MenuInitial()) {
    on<MenuLoadAll>(_onLoadAll);
    on<MenuLoadByCategory>(_onLoadByCategory);
    on<MenuCreate>(_onCreate);
    on<MenuUpdate>(_onUpdate);
    on<MenuToggleStatus>(_onToggleStatus);
    on<MenuDelete>(_onDelete);
    on<MenuSearch>(_onSearch);

    AppLogger.info('MenuBloc initialized', tag: 'MENU');
  }

  List<Menu> _allMenus = [];
  List<Category> _categories = [];

  Future<void> _onLoadAll(MenuLoadAll event, Emitter<MenuState> emit) async {
    AppLogger.blocEvent('MenuBloc', 'MenuLoadAll');
    emit(const MenuLoading());

    try {
      final results = await Future.wait([
        _menuRepository.getCategories(),
        _menuRepository.getMenus(),
      ]);

      _categories = results[0] as List<Category>;
      _allMenus = results[1] as List<Menu>;

      emit(MenuLoaded(menus: _allMenus, categories: _categories));

      AppLogger.info('Loaded ${_allMenus.length} menus', tag: 'MENU');
    } catch (e) {
      AppLogger.error('Failed to load menus', tag: 'MENU', error: e);
      emit(MenuError(e.toString()));
    }
  }

  Future<void> _onLoadByCategory(
    MenuLoadByCategory event,
    Emitter<MenuState> emit,
  ) async {
    AppLogger.blocEvent(
      'MenuBloc',
      'MenuLoadByCategory',
      data: {'categoryId': event.categoryId},
    );
    emit(const MenuLoading());

    try {
      final menus = await _menuRepository.getMenus(
        categoryId: event.categoryId,
      );
      emit(
        MenuLoaded(
          menus: menus,
          categories: _categories,
          selectedCategoryId: event.categoryId,
        ),
      );
    } catch (e) {
      AppLogger.error(
        'Failed to load menus by category',
        tag: 'MENU',
        error: e,
      );
      emit(MenuError(e.toString()));
    }
  }

  Future<void> _onCreate(MenuCreate event, Emitter<MenuState> emit) async {
    AppLogger.blocEvent(
      'MenuBloc',
      'MenuCreate',
      data: {'name': event.menu.name},
    );
    emit(const MenuLoading());

    try {
      final newMenu = await _menuRepository.createMenu(event.menu);
      _allMenus = [..._allMenus, newMenu];

      emit(MenuOperationSuccess('Menu "${newMenu.name}" created successfully'));
      emit(MenuLoaded(menus: _allMenus, categories: _categories));

      AppLogger.info('Menu created: ${newMenu.name}', tag: 'MENU');
    } catch (e) {
      AppLogger.error('Failed to create menu', tag: 'MENU', error: e);
      emit(MenuError(e.toString()));
      emit(MenuLoaded(menus: _allMenus, categories: _categories));
    }
  }

  Future<void> _onUpdate(MenuUpdate event, Emitter<MenuState> emit) async {
    AppLogger.blocEvent('MenuBloc', 'MenuUpdate', data: {'id': event.menu.id});
    emit(const MenuLoading());

    try {
      final updatedMenu = await _menuRepository.updateMenu(event.menu);
      _allMenus = _allMenus
          .map((m) => m.id == updatedMenu.id ? updatedMenu : m)
          .toList();

      emit(
        MenuOperationSuccess('Menu "${updatedMenu.name}" updated successfully'),
      );
      emit(MenuLoaded(menus: _allMenus, categories: _categories));

      AppLogger.info('Menu updated: ${updatedMenu.name}', tag: 'MENU');
    } catch (e) {
      AppLogger.error('Failed to update menu', tag: 'MENU', error: e);
      emit(MenuError(e.toString()));
      emit(MenuLoaded(menus: _allMenus, categories: _categories));
    }
  }

  Future<void> _onToggleStatus(
    MenuToggleStatus event,
    Emitter<MenuState> emit,
  ) async {
    AppLogger.blocEvent(
      'MenuBloc',
      'MenuToggleStatus',
      data: {'id': event.menuId},
    );

    try {
      await _menuRepository.toggleMenuStatus(event.menuId, event.isActive);
      _allMenus = _allMenus.map((m) {
        if (m.id == event.menuId) {
          return m.copyWith(isActive: event.isActive);
        }
        return m;
      }).toList();

      emit(
        MenuOperationSuccess(
          event.isActive ? 'Menu activated' : 'Menu deactivated',
        ),
      );
      emit(MenuLoaded(menus: _allMenus, categories: _categories));

      AppLogger.info('Menu status toggled: ${event.menuId}', tag: 'MENU');
    } catch (e) {
      AppLogger.error('Failed to toggle menu status', tag: 'MENU', error: e);
      emit(MenuError(e.toString()));
      emit(MenuLoaded(menus: _allMenus, categories: _categories));
    }
  }

  Future<void> _onDelete(MenuDelete event, Emitter<MenuState> emit) async {
    AppLogger.blocEvent('MenuBloc', 'MenuDelete', data: {'id': event.menuId});
    emit(const MenuLoading());

    try {
      await _menuRepository.deleteMenu(event.menuId);
      final deletedMenu = _allMenus.firstWhere((m) => m.id == event.menuId);
      _allMenus = _allMenus.where((m) => m.id != event.menuId).toList();

      emit(MenuOperationSuccess('Menu "${deletedMenu.name}" deleted'));
      emit(MenuLoaded(menus: _allMenus, categories: _categories));

      AppLogger.info('Menu deleted: ${event.menuId}', tag: 'MENU');
    } catch (e) {
      AppLogger.error('Failed to delete menu', tag: 'MENU', error: e);
      emit(MenuError(e.toString()));
      emit(MenuLoaded(menus: _allMenus, categories: _categories));
    }
  }

  void _onSearch(MenuSearch event, Emitter<MenuState> emit) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(MenuLoaded(menus: _allMenus, categories: _categories));
      return;
    }

    final filtered = _allMenus.where((m) {
      return m.name.toLowerCase().contains(query) ||
          (m.description?.toLowerCase().contains(query) ?? false);
    }).toList();

    emit(
      MenuLoaded(
        menus: filtered,
        categories: _categories,
        searchQuery: event.query,
      ),
    );
  }
}
