import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';

abstract class MealFavoritesLocalDataSource {
  Future<List<Favorite>> fetchFavorites();

  Future<void> addFavorite(Food item);

  Future<void> removeFavorite(Food item);
}

class MealFavoritesLocalDataSourceImpl implements MealFavoritesLocalDataSource {
  final AppDatabase _database = Modular.get<AppDatabase>();

  @override
  Future<List<Favorite>> fetchFavorites() async {
    try {
      return await _database.getAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addFavorite(Food item) async {
    try {
      return await _database.addFavorite(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite(Food item) async {
    try {
      return await _database.removeFavorite(item);
    } catch (e) {
      rethrow;
    }
  }
}
