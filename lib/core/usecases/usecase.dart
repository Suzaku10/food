import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class IdMealParams extends Equatable {
  final String? id;

  const IdMealParams({this.id});

  @override
  List<Object?> get props => [id];
}

class FoodParams extends Equatable {
  final Food? food;

  const FoodParams({this.food});

  @override
  List<Object?> get props => [food];
}
