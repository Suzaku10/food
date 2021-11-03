import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_response_model.g.dart';

@JsonSerializable()
class FoodResponseModel extends Food {
   FoodResponseModel(
      {idMeal,
      strMeal,
      strDrinkAlternate,
      strCategory,
      strArea,
      strInstructions,
      strMealThumb,
      strTags,
      strYoutube,
      strMeasure1,
      strMeasure2,
      strMeasure3,
      strMeasure4,
      strMeasure5,
      strMeasure6,
      strMeasure7,
      strMeasure8,
      strMeasure9,
      strMeasure10,
      strMeasure11,
      strMeasure12,
      strMeasure13,
      strMeasure14,
      strMeasure15,
      strMeasure16,
      strMeasure17,
      strMeasure18,
      strMeasure19,
      strMeasure20,
      strSource,
      strImageSource,
      strCreativeCommonsConfirmed,
      dateModified})
      : super(
            idMeal: idMeal,
            strMeal: strMeal,
            strDrinkAlternate: strDrinkAlternate,
            strCategory: strCategory,
            strArea: strArea,
            strInstructions: strInstructions,
            strMealThumb: strMealThumb,
            strTags: strTags,
            strYoutube: strYoutube,
            strMeasure1: strMeasure1,
            strMeasure2: strMeasure2,
            strMeasure3: strMeasure3,
            strMeasure4: strMeasure4,
            strMeasure5: strMeasure5,
            strMeasure6: strMeasure6,
            strMeasure7: strMeasure7,
            strMeasure8: strMeasure8,
            strMeasure9: strMeasure9,
            strMeasure10: strMeasure10,
            strMeasure11: strMeasure11,
            strMeasure12: strMeasure12,
            strMeasure13: strMeasure13,
            strMeasure14: strMeasure14,
            strMeasure15: strMeasure15,
            strMeasure16: strMeasure16,
            strMeasure17: strMeasure17,
            strMeasure18: strMeasure18,
            strMeasure19: strMeasure19,
            strMeasure20: strMeasure20,
            strSource: strSource,
            strImageSource: strImageSource,
            strCreativeCommonsConfirmed: strCreativeCommonsConfirmed,
            dateModified: dateModified);

  factory FoodResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FoodResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodResponseModelToJson(this);
}
