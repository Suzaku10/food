import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/favorite/domain/repositories/food_favorite_repositories.dart';

class FavoritesFromDatabase implements UseCase<List<Favorite>, NoParams> {
  final FoodFavoriteRepository repository;

  FavoritesFromDatabase(this.repository);

  @override
  Future<Either<Failure, List<Favorite>>> call(NoParams params) async {
    return await repository.fetchFavorites();
  }
}
