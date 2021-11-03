import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

abstract class FoodDetailsRepository {
  Future<Either<Failure, Food>> fetchDetailById(String id);
}
