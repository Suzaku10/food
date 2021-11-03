import 'package:flutter_modular/flutter_modular.dart';
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

        // repository
        Bind.lazySingleton<FoodListRepository>(
          (i) => FoodListRepositoryImpl(
            remoteDataSource: Modular.get<MealsRemoteDataSource>(),
          ),
        ),

        // usecase
        Bind.lazySingleton<usecase.FetchMeals>(
          (i) => usecase.FetchMeals(Modular.get<FoodListRepository>()),
        ),

        // bloc
        Bind.factory<FoodListBloc>(
          (i) => FoodListBloc(meals: Modular.get<usecase.FetchMeals>()),
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
          child: (context, args) => const FoodListPage(),
        ),
      ];
}
