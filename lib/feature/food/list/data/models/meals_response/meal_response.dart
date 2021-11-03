import 'package:food/feature/food/list/data/models/food_response/food_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_response.g.dart';

@JsonSerializable()
class MealsResponseModel {
  final List<FoodResponseModel>? meals;

  MealsResponseModel({this.meals});

  factory MealsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MealsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealsResponseModelToJson(this);
}
