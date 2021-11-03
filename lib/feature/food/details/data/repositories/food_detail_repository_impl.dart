import 'package:dartz/dartz.dart';
import 'package:food/core/error/exceptions.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/feature/food/details/data/datasources/meal_detail_remote_datasources.dart';
import 'package:food/feature/food/details/domain/repositories/food_details_repository.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

class FoodDetailsRepositoryImpl implements FoodDetailsRepository {
  final MealDetailRemoteDataSource remoteDataSource;

  FoodDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Food>> fetchDetailById(String id) async {
    try {
      final remoteTrivia = await remoteDataSource.fetchDetailById(id);
      return Right(remoteTrivia);
    } on ServerException {
      return Left(ServerFailure());
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      return Left(OtherFailure());
    }
  }
}
