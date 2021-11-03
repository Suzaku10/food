import 'package:equatable/equatable.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodFavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFavorites extends FoodFavoriteEvent {}

class AddFavorites extends FoodFavoriteEvent {
  final Food food;

  AddFavorites(this.food);

  @override
  List<Object> get props => [food];
}

class RemoveFavorite extends FoodFavoriteEvent {
  final Food food;

  RemoveFavorite(this.food);

  @override
  List<Object> get props => [food];
}
