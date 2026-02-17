part of 'new_order_bloc.dart';

abstract class NewOrderState extends Equatable {
  const NewOrderState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class NewOrderInitial extends NewOrderState {}

/// Loading data
class NewOrderLoading extends NewOrderState {}

/// Data loaded successfully
class NewOrderLoaded extends NewOrderState {
  final List<Category> categories;
  final List<Menu> allMenus;
  final List<Menu> filteredMenus;
  final int? selectedCategoryId;
  final String searchQuery;
  final bool isRefreshing;
  final String? error;

  const NewOrderLoaded({
    required this.categories,
    required this.allMenus,
    required this.filteredMenus,
    this.selectedCategoryId,
    required this.searchQuery,
    this.isRefreshing = false,
    this.error,
  });

  NewOrderLoaded copyWith({
    List<Category>? categories,
    List<Menu>? allMenus,
    List<Menu>? filteredMenus,
    int? selectedCategoryId,
    String? searchQuery,
    bool? isRefreshing,
    String? error,
  }) {
    return NewOrderLoaded(
      categories: categories ?? this.categories,
      allMenus: allMenus ?? this.allMenus,
      filteredMenus: filteredMenus ?? this.filteredMenus,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    allMenus,
    filteredMenus,
    selectedCategoryId,
    searchQuery,
    isRefreshing,
    error,
  ];
}

/// Error loading data
class NewOrderError extends NewOrderState {
  final String message;

  const NewOrderError({required this.message});

  @override
  List<Object?> get props => [message];
}
