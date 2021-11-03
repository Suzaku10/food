import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/feature/food/details/data/datasources/meal_detail_remote_datasources.dart';
import 'package:food/feature/food/details/data/repositories/food_detail_repository_impl.dart';
import 'package:food/feature/food/details/domain/repositories/food_details_repository.dart';
import 'package:food/feature/food/details/domain/usecases/fetch_meal_detail.dart';
import 'package:food/feature/food/details/presentation/bloc/bloc.dart';
import 'package:food/feature/food/details/presentation/pages/food_detail_page.dart';
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

        // usecase
        Bind.lazySingleton<usecase.FetchMeals>(
          (i) => usecase.FetchMeals(Modular.get<FoodListRepository>()),
        ),

        Bind.lazySingleton<FetchMealDetail>(
          (i) => FetchMealDetail(Modular.get<FoodDetailsRepository>()),
        ),

        // bloc
        Bind.factory<FoodListBloc>(
          (i) => FoodListBloc(meals: Modular.get<usecase.FetchMeals>()),
        ),

        Bind.factory<FoodDetailBloc>(
          (i) => FoodDetailBloc(detail: Modular.get<FetchMealDetail>()),
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
      ];
}
