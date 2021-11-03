import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/feature/food/details/domain/usecases/fetch_meal_detail.dart';
import 'package:food/feature/food/details/presentation/bloc/bloc.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final FetchMealDetail fetchMealDetail;

  FoodDetailBloc({required FetchMealDetail detail})
      : fetchMealDetail = detail,
        super(Initial());

  @override
  Stream<FoodDetailState> mapEventToState(FoodDetailEvent event) async* {
    if (event is FetchDetailByMealId) {
      yield Loading();
      final fetchData = await fetchMealDetail(IdMealParams(id: event.id));
      yield* _eitherLoadedOrErrorState(fetchData);
    }
  }

  Stream<FoodDetailState> _eitherLoadedOrErrorState(
      Either<Failure, Food> failureOrFood) async* {
    yield failureOrFood.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (detail) => Loaded(detail: detail),
    );
  }

  String? _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'SERVER_FAILURE_MESSAGE';
      case CacheFailure:
        return 'CACHE_FAILURE_MESSAGE';
      case TimeoutFailure:
        return 'TIMEOUT_MESSAGE';
      default:
        return 'Unexpected error';
    }
  }
}
