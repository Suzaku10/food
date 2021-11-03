import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/core/error/failures.dart';
import 'package:food/core/usecases/usecase.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/favorite/domain/usecases/add_favorite_to_database.dart';
import 'package:food/feature/food/favorite/domain/usecases/favorite_from_database.dart';
import 'package:food/feature/food/favorite/domain/usecases/remove_favorite.dart';
import 'package:food/feature/food/favorite/presentation/bloc/food_favorite_event.dart';
import 'package:food/feature/food/favorite/presentation/bloc/food_favorite_state.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

class FoodFavoriteBloc extends Bloc<FoodFavoriteEvent, FoodFavoriteState> {
  final FavoritesFromDatabase fetchFavorites;
  final AddFavoriteToDatabase addFavoriteToDatabase;
  final RemoveFavorites removeFavoriteFromDatabase;

  FoodFavoriteBloc({
    required FavoritesFromDatabase meals,
    required AddFavoriteToDatabase addFavorite,
    required RemoveFavorites removeFavorites,
  })  : fetchFavorites = meals,
        addFavoriteToDatabase = addFavorite,
        removeFavoriteFromDatabase = removeFavorites,
        super(Initial());

  @override
  Stream<FoodFavoriteState> mapEventToState(FoodFavoriteEvent event) async* {
    if (event is FetchFavorites) {
      yield Loading();
      final fetchData = await fetchFavorites(NoParams());
      yield* _eitherLoadedOrErrorState(fetchData);
    } else if (event is AddFavorites) {
      yield Loading();
      await addFavoriteToDatabase(
        FoodParams(food: event.food),
      );
      yield Success();
    } else if (event is RemoveFavorite) {
      yield Loading();
      await removeFavoriteFromDatabase(FoodParams(food: event.food));
      yield Success();
    }
  }

  Stream<FoodFavoriteState> _eitherLoadedOrErrorState(
      Either<Failure, List<Favorite>> failureOrFood) async* {
    yield failureOrFood.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (meals) => Loaded(favorites: meals),
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
