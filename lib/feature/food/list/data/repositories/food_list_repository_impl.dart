import 'package:dartz/dartz.dart';
import 'package:food/core/error/exceptions.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/feature/food/list/data/datasources/meals_remote_datasources.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:food/feature/food/list/domain/repositories/food_list_repository.dart';

class FoodListRepositoryImpl implements FoodListRepository {
  final MealsRemoteDataSource remoteDataSource;

  FoodListRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Food>>> fetchMeals() async {
    try {
      final remoteTrivia = await remoteDataSource.fetchMeals();
      return Right(
        remoteTrivia.meals!.map((e) => e).toList(),
      );
    } on ServerException {
      return Left(ServerFailure());
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      return Left(OtherFailure());
    }
  }
}
