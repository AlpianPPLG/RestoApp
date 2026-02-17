part of 'new_order_bloc.dart';

abstract class NewOrderEvent extends Equatable {
  const NewOrderEvent();

  @override
  List<Object?> get props => [];
}

/// Load initial data (categories and menus)
class NewOrderLoadData extends NewOrderEvent {
  const NewOrderLoadData();
}

/// Select a category to filter menus
class NewOrderCategorySelected extends NewOrderEvent {
  final int? categoryId;

  const NewOrderCategorySelected({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

/// Search query changed
class NewOrderSearchChanged extends NewOrderEvent {
  final String query;

  const NewOrderSearchChanged({required this.query});

  @override
  List<Object?> get props => [query];
}

/// Refresh menu data
class NewOrderRefresh extends NewOrderEvent {
  const NewOrderRefresh();
}
