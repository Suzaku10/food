import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/details/data/datasources/meal_detail_remote_datasources.dart';
import 'package:food/feature/food/details/data/repositories/food_detail_repository_impl.dart';
import 'package:food/feature/food/details/domain/repositories/food_details_repository.dart';
import 'package:food/feature/food/details/domain/usecases/fetch_meal_detail.dart';
import 'package:food/feature/food/details/presentation/bloc/bloc.dart';
import 'package:food/feature/food/details/presentation/pages/food_detail_page.dart';
import 'package:food/feature/food/favorite/data/datasources/meal_favorite_local_datasources.dart';
import 'package:food/feature/food/favorite/data/repositories/food_favorite_repository.dart';
import 'package:food/feature/food/favorite/domain/repositories/food_favorite_repositories.dart';
import 'package:food/feature/food/favorite/domain/usecases/add_favorite_to_database.dart';
import 'package:food/feature/food/favorite/domain/usecases/favorite_from_database.dart';
import 'package:food/feature/food/favorite/domain/usecases/remove_favorite.dart';
import 'package:food/feature/food/favorite/presentation/bloc/bloc.dart';
import 'package:food/feature/food/favorite/presentation/pages/food_favorite_page.dart';
import 'package:food/feature/food/list/data/datasources/meals_remote_datasources.dart';
import 'package:food/feature/food/list/data/repositories/food_list_repository_impl.dart';
import 'package:food/feature/food/list/domain/repositories/food_list_repository.dart';
import 'package:food/feature/food/list/presentation/bloc/bloc.dart';
import 'package:food/feature/food/list/presentation/pages/food_list_page.dart';
import 'package:food/feature/food/list/domain/usecases/fetch_meal.dart'
    as usecase;

final sl = Modular.get;

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // data source
        Bind.lazySingleton<MealsRemoteDataSource>(
          (i) => MealsRemoteDataSourceImpl(),
        ),

        Bind.lazySingleton<MealDetailRemoteDataSource>(
          (i) => MealDetailRemoteDataSourceImpl(),
        ),

        Bind.lazySingleton<AppDatabase>((i) => AppDatabase()),

        Bind.lazySingleton<MealFavoritesLocalDataSource>(
            (i) => MealFavoritesLocalDataSourceImpl()),

        // repository
        Bind.lazySingleton<FoodListRepository>(
          (i) => FoodListRepositoryImpl(
            remoteDataSource: Modular.get<MealsRemoteDataSource>(),
          ),
        ),

        Bind.lazySingleton<FoodDetailsRepository>(
          (i) => FoodDetailsRepositoryImpl(
            remoteDataSource: Modular.get<MealDetailRemoteDataSource>(),
          ),
        ),

        Bind.lazySingleton<FoodFavoriteRepository>(
          (i) => FoodFavoriteRepositoryImpl(
            localDataSource: Modular.get<MealFavoritesLocalDataSource>(),
          ),
        ),

        // usecase
        Bind.lazySingleton<usecase.FetchMeals>(
          (i) => usecase.FetchMeals(Modular.get<FoodListRepository>()),
        ),

        Bind.lazySingleton<FetchMealDetail>(
          (i) => FetchMealDetail(Modular.get<FoodDetailsRepository>()),
        ),

        Bind.lazySingleton<RemoveFavorites>(
          (i) => RemoveFavorites(Modular.get<FoodFavoriteRepository>()),
        ),
        Bind.lazySingleton<AddFavoriteToDatabase>(
          (i) => AddFavoriteToDatabase(Modular.get<FoodFavoriteRepository>()),
        ),
        Bind.lazySingleton<FavoritesFromDatabase>(
          (i) => FavoritesFromDatabase(Modular.get<FoodFavoriteRepository>()),
        ),

        // bloc
        Bind.factory<FoodListBloc>(
          (i) => FoodListBloc(meals: Modular.get<usecase.FetchMeals>()),
        ),

        Bind.factory<FoodDetailBloc>(
          (i) => FoodDetailBloc(detail: Modular.get<FetchMealDetail>()),
        ),

        Bind.factory<FoodFavoriteBloc>(
          (i) => FoodFavoriteBloc(
              meals: Modular.get<FavoritesFromDatabase>(),
              addFavorite: Modular.get<AddFavoriteToDatabase>(),
              removeFavorites: Modular.get<RemoveFavorites>()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const FoodListPage(),
        ),
        ChildRoute(
          '/detail/:id',
          child: (context, args) => FoodDetailPage(
            name: args.params['id'],
          ),
        ),
        ChildRoute(
          '/favorites',
          child: (context, args) => const FoodFavoritePage(),
        ),
      ];
}
