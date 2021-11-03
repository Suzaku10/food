// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_helper.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Favorite extends DataClass implements Insertable<Favorite> {
  final String mealId;
  final String mealName;
  final String mealCategory;
  final String mealArea;
  Favorite(
      {required this.mealId,
      required this.mealName,
      required this.mealCategory,
      required this.mealArea});
  factory Favorite.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Favorite(
      mealId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}meal_id'])!,
      mealName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}meal_name'])!,
      mealCategory: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}meal_category'])!,
      mealArea: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}meal_area'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['meal_id'] = Variable<String>(mealId);
    map['meal_name'] = Variable<String>(mealName);
    map['meal_category'] = Variable<String>(mealCategory);
    map['meal_area'] = Variable<String>(mealArea);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      mealId: Value(mealId),
      mealName: Value(mealName),
      mealCategory: Value(mealCategory),
      mealArea: Value(mealArea),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Favorite(
      mealId: serializer.fromJson<String>(json['mealId']),
      mealName: serializer.fromJson<String>(json['mealName']),
      mealCategory: serializer.fromJson<String>(json['mealCategory']),
      mealArea: serializer.fromJson<String>(json['mealArea']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mealId': serializer.toJson<String>(mealId),
      'mealName': serializer.toJson<String>(mealName),
      'mealCategory': serializer.toJson<String>(mealCategory),
      'mealArea': serializer.toJson<String>(mealArea),
    };
  }

  Favorite copyWith(
          {String? mealId,
          String? mealName,
          String? mealCategory,
          String? mealArea}) =>
      Favorite(
        mealId: mealId ?? this.mealId,
        mealName: mealName ?? this.mealName,
        mealCategory: mealCategory ?? this.mealCategory,
        mealArea: mealArea ?? this.mealArea,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('mealId: $mealId, ')
          ..write('mealName: $mealName, ')
          ..write('mealCategory: $mealCategory, ')
          ..write('mealArea: $mealArea')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mealId, mealName, mealCategory, mealArea);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.mealId == this.mealId &&
          other.mealName == this.mealName &&
          other.mealCategory == this.mealCategory &&
          other.mealArea == this.mealArea);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<String> mealId;
  final Value<String> mealName;
  final Value<String> mealCategory;
  final Value<String> mealArea;
  const FavoritesCompanion({
    this.mealId = const Value.absent(),
    this.mealName = const Value.absent(),
    this.mealCategory = const Value.absent(),
    this.mealArea = const Value.absent(),
  });
  FavoritesCompanion.insert({
    required String mealId,
    required String mealName,
    required String mealCategory,
    required String mealArea,
  })  : mealId = Value(mealId),
        mealName = Value(mealName),
        mealCategory = Value(mealCategory),
        mealArea = Value(mealArea);
  static Insertable<Favorite> custom({
    Expression<String>? mealId,
    Expression<String>? mealName,
    Expression<String>? mealCategory,
    Expression<String>? mealArea,
  }) {
    return RawValuesInsertable({
      if (mealId != null) 'meal_id': mealId,
      if (mealName != null) 'meal_name': mealName,
      if (mealCategory != null) 'meal_category': mealCategory,
      if (mealArea != null) 'meal_area': mealArea,
    });
  }

  FavoritesCompanion copyWith(
      {Value<String>? mealId,
      Value<String>? mealName,
      Value<String>? mealCategory,
      Value<String>? mealArea}) {
    return FavoritesCompanion(
      mealId: mealId ?? this.mealId,
      mealName: mealName ?? this.mealName,
      mealCategory: mealCategory ?? this.mealCategory,
      mealArea: mealArea ?? this.mealArea,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (mealName.present) {
      map['meal_name'] = Variable<String>(mealName.value);
    }
    if (mealCategory.present) {
      map['meal_category'] = Variable<String>(mealCategory.value);
    }
    if (mealArea.present) {
      map['meal_area'] = Variable<String>(mealArea.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('mealId: $mealId, ')
          ..write('mealName: $mealName, ')
          ..write('mealCategory: $mealCategory, ')
          ..write('mealArea: $mealArea')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  final GeneratedDatabase _db;
  final String? _alias;
  $FavoritesTable(this._db, [this._alias]);
  final VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  late final GeneratedColumn<String?> mealId = GeneratedColumn<String?>(
      'meal_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _mealNameMeta = const VerificationMeta('mealName');
  late final GeneratedColumn<String?> mealName = GeneratedColumn<String?>(
      'meal_name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _mealCategoryMeta =
      const VerificationMeta('mealCategory');
  late final GeneratedColumn<String?> mealCategory = GeneratedColumn<String?>(
      'meal_category', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _mealAreaMeta = const VerificationMeta('mealArea');
  late final GeneratedColumn<String?> mealArea = GeneratedColumn<String?>(
      'meal_area', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [mealId, mealName, mealCategory, mealArea];
  @override
  String get aliasedName => _alias ?? 'favorites';
  @override
  String get actualTableName => 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('meal_id')) {
      context.handle(_mealIdMeta,
          mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta));
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('meal_name')) {
      context.handle(_mealNameMeta,
          mealName.isAcceptableOrUnknown(data['meal_name']!, _mealNameMeta));
    } else if (isInserting) {
      context.missing(_mealNameMeta);
    }
    if (data.containsKey('meal_category')) {
      context.handle(
          _mealCategoryMeta,
          mealCategory.isAcceptableOrUnknown(
              data['meal_category']!, _mealCategoryMeta));
    } else if (isInserting) {
      context.missing(_mealCategoryMeta);
    }
    if (data.containsKey('meal_area')) {
      context.handle(_mealAreaMeta,
          mealArea.isAcceptableOrUnknown(data['meal_area']!, _mealAreaMeta));
    } else if (isInserting) {
      context.missing(_mealAreaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mealId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Favorite.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favorites];
}
