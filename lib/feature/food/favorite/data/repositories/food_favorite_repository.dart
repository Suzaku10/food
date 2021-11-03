import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/favorite/data/datasources/meal_favorite_local_datasources.dart';
import 'package:food/feature/food/favorite/domain/repositories/food_favorite_repositories.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

class FoodFavoriteRepositoryImpl implements FoodFavoriteRepository {
  final MealFavoritesLocalDataSource localDataSource;

  FoodFavoriteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addToFavorite(Food food) async {
    try {
      await localDataSource.addFavorite(food);
      return const Right(null);
    } catch (e) {
      return Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, List<Favorite>>> fetchFavorites() async {
    try {
      final remoteTrivia = await localDataSource.fetchFavorites();
      return Right(remoteTrivia);
    } catch (e) {
      return Left(OtherFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorite(Food food) async {
    try {
      await localDataSource.removeFavorite(food);
      return const Right(null);
    } catch (e) {
      return Left(OtherFailure());
    }
  }
}
