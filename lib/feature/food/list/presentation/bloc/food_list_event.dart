import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMeals extends FoodListEvent {}
