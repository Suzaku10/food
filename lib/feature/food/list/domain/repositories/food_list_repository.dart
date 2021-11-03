import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

abstract class FoodListRepository {
  Future<Either<Failure, List<Food>>> fetchMeals();
}