import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:food/feature/food/list/domain/repositories/food_list_repository.dart';

class FetchMeals implements UseCase<List<Food>, NoParams> {
  final FoodListRepository repository;

  FetchMeals(this.repository);

  @override
  Future<Either<Failure, List<Food>>> call(NoParams params) async {
    return await repository.fetchMeals();
  }
}
