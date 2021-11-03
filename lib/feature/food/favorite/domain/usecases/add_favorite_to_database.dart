import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/feature/food/favorite/domain/repositories/food_favorite_repositories.dart';

class AddFavoriteToDatabase implements UseCase<void, FoodParams> {
  final FoodFavoriteRepository repository;

  AddFavoriteToDatabase(this.repository);

  @override
  Future<Either<Failure, void>> call(FoodParams params) async {
    return await repository.addToFavorite(params.food!);
  }
}