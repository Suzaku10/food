import 'package:equatable/equatable.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends FoodDetailState {}

class Empty extends FoodDetailState {}

class Loading extends FoodDetailState {}

class Loaded extends FoodDetailState {
  final Food detail;

  Loaded({required this.detail});

  @override
  List<Object> get props => [detail];
}

class Error extends FoodDetailState {
  final String? message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
