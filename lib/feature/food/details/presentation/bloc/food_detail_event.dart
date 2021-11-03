import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FoodDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDetailByMealId extends FoodDetailEvent {
  final String id;

  FetchDetailByMealId(this.id);

  @override
  List<Object> get props => [id];
}
