import 'package:equatable/equatable.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends FoodListState {}

class Loading extends FoodListState {}

class Loaded extends FoodListState {
  final List<Food> meals;

  Loaded({required this.meals});

  @override
  List<Object> get props => [meals];
}

class Error extends FoodListState {
  final String? message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
