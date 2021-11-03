import 'package:dartz/dartz.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

abstract class FoodFavoriteRepository {
  Future<Either<Failure, List<Favorite>>> fetchFavorites();

  Future<Either<Failure, void>> addToFavorite(Food food);

  Future<Either<Failure, void>> removeFromFavorite(Food food);
}
