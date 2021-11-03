import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_helper.g.dart';

class Favorites extends Table {
  @override
  Set<Column> get primaryKey => {mealId, mealId};

  TextColumn get mealId => text()();

  TextColumn get mealName => text()();

  TextColumn get mealCategory => text()();

  TextColumn get mealArea => text()();
}

@UseMoor(tables: [Favorites])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<Favorite>> getAll() => select(favorites).get();

  Future<void> addFavorite(Food item) => into(favorites).insert(
        Favorite(
            mealId: item.idMeal!,
            mealName: item.strMeal ?? '',
            mealCategory: item.strCategory ?? '',
            mealArea: item.strArea ?? ''),
      );

  Future<void> removeFavorite(Food item) => delete(favorites).delete(
        Favorite(
            mealId: item.idMeal!,
            mealName: item.strMeal ?? '',
            mealCategory: item.strCategory ?? '',
            mealArea: item.strArea ?? ''),
      );
}
