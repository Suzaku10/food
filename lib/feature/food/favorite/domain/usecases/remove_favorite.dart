import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/feature/food/favorite/domain/repositories/food_favorite_repositories.dart';

class RemoveFavorites implements UseCase<void, FoodParams> {
  final FoodFavoriteRepository repository;

  RemoveFavorites(this.repository);

  @override
  Future<Either<Failure, void>> call(FoodParams params) async {
    return await repository.removeFromFavorite(params.food!);
  }
}
