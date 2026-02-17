import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restoapp/core/error/exceptions.dart';
import 'package:restoapp/domain/entities/category.dart';
import 'package:restoapp/domain/entities/menu.dart';
import 'package:restoapp/domain/repositories/menu_repository.dart';

part 'new_order_event.dart';
part 'new_order_state.dart';

@injectable
class NewOrderBloc extends Bloc<NewOrderEvent, NewOrderState> {
  final MenuRepository menuRepository;

  NewOrderBloc({required this.menuRepository}) : super(NewOrderInitial()) {
    on<NewOrderLoadData>(_onLoadData);
    on<NewOrderCategorySelected>(_onCategorySelected);
    on<NewOrderSearchChanged>(_onSearchChanged);
    on<NewOrderRefresh>(_onRefresh);
  }

  Future<void> _onLoadData(
    NewOrderLoadData event,
    Emitter<NewOrderState> emit,
  ) async {
    emit(NewOrderLoading());

    try {
      // Load categories and menus in parallel
      final results = await Future.wait([
        menuRepository.getCategories(),
        menuRepository.getMenus(),
      ]);

      final categories = results[0] as List<Category>;
      final menus = results[1] as List<Menu>;

      emit(
        NewOrderLoaded(
          categories: categories,
          allMenus: menus,
          filteredMenus: menus,
          selectedCategoryId: null,
          searchQuery: '',
        ),
      );
    } on ServerException catch (e) {
      emit(NewOrderError(message: e.message));
    } catch (e) {
      emit(const NewOrderError(message: 'Failed to load menu data'));
    }
  }

  void _onCategorySelected(
    NewOrderCategorySelected event,
    Emitter<NewOrderState> emit,
  ) {
    if (state is! NewOrderLoaded) return;

    final currentState = state as NewOrderLoaded;
    final filteredMenus = _filterMenus(
      currentState.allMenus,
      event.categoryId,
      currentState.searchQuery,
    );

    emit(
      currentState.copyWith(
        selectedCategoryId: event.categoryId,
        filteredMenus: filteredMenus,
      ),
    );
  }

  void _onSearchChanged(
    NewOrderSearchChanged event,
    Emitter<NewOrderState> emit,
  ) {
    if (state is! NewOrderLoaded) return;

    final currentState = state as NewOrderLoaded;
    final filteredMenus = _filterMenus(
      currentState.allMenus,
      currentState.selectedCategoryId,
      event.query,
    );

    emit(
      currentState.copyWith(
        searchQuery: event.query,
        filteredMenus: filteredMenus,
      ),
    );
  }

  Future<void> _onRefresh(
    NewOrderRefresh event,
    Emitter<NewOrderState> emit,
  ) async {
    if (state is! NewOrderLoaded) return;

    final currentState = state as NewOrderLoaded;
    emit(currentState.copyWith(isRefreshing: true));

    try {
      // Reload data
      final results = await Future.wait([
        menuRepository.getCategories(),
        menuRepository.getMenus(),
      ]);

      final categories = results[0] as List<Category>;
      final menus = results[1] as List<Menu>;

      final filteredMenus = _filterMenus(
        menus,
        currentState.selectedCategoryId,
        currentState.searchQuery,
      );

      emit(
        currentState.copyWith(
          categories: categories,
          allMenus: menus,
          filteredMenus: filteredMenus,
          isRefreshing: false,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        currentState.copyWith(
          isRefreshing: false,
          error: 'Failed to refresh data',
        ),
      );
    }
  }

  List<Menu> _filterMenus(
    List<Menu> menus,
    int? categoryId,
    String searchQuery,
  ) {
    var filtered = menus.where((menu) => menu.isActive);

    // Filter by category
    if (categoryId != null) {
      filtered = filtered.where((menu) => menu.categoryId == categoryId);
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      final lowercaseQuery = searchQuery.toLowerCase();
      filtered = filtered.where(
        (menu) => menu.name.toLowerCase().contains(lowercaseQuery),
      );
    }

    return filtered.toList();
  }
}
