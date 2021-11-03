// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealsResponseModel _$MealsResponseModelFromJson(Map<String, dynamic> json) =>
    MealsResponseModel(
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => FoodResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealsResponseModelToJson(MealsResponseModel instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };
