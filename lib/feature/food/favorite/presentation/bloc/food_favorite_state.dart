import 'package:equatable/equatable.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodFavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends FoodFavoriteState {}

class Empty extends FoodFavoriteState {}

class Loading extends FoodFavoriteState {}

class Success extends FoodFavoriteState {}

class Loaded extends FoodFavoriteState {
  final List<Favorite> favorites;

  Loaded({required this.favorites});

  @override
  List<Object> get props => [favorites];
}

class Error extends FoodFavoriteState {
  final String? message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
