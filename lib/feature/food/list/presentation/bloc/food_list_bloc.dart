import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:food/feature/food/list/domain/usecases/fetch_meal.dart'
    as usecase;
import 'package:food/feature/food/list/presentation/bloc/bloc.dart';

class FoodListBloc extends Bloc<FoodListEvent, FoodListState> {
  final usecase.FetchMeals fetchMeals;

  FoodListBloc({
    required usecase.FetchMeals meals,
  })  : fetchMeals = meals,
        super(Initial());

  @override
  Stream<FoodListState> mapEventToState(FoodListEvent event) async* {
    if (event is FetchMeals) {
      yield Loading();
      final fetchData = await fetchMeals(NoParams());
      yield* _eitherLoadedOrErrorState(fetchData);
    }
  }

  Stream<FoodListState> _eitherLoadedOrErrorState(
      Either<Failure, List<Food>> failureOrFood) async* {
    yield failureOrFood.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (meals) => Loaded(meals: meals),
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
