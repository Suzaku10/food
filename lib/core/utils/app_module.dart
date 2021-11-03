import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/feature/food/list/presentation/pages/food_list_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

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
