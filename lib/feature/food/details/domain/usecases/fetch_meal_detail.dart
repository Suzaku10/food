import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/feature/food/details/domain/repositories/food_details_repository.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

class FetchMealDetail implements UseCase<Food, IdMealParams> {
  final FoodDetailsRepository repository;

  FetchMealDetail(this.repository);

  @override
  Future<Either<Failure, Food>> call(IdMealParams params) async {
    return await repository.fetchDetailById(params.id!);
  }
}
