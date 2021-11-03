import 'package:food/core/network/base_dio_service.dart';
import 'package:food/core/network/service_url.dart';
import 'package:food/feature/food/list/data/models/food_response/food_response_model.dart';
import 'package:food/feature/food/list/data/models/meals_response/meal_response.dart';

abstract class MealDetailRemoteDataSource {
  Future<FoodResponseModel> fetchDetailById(String id);
}

class MealDetailRemoteDataSourceImpl extends BaseServiceDio
    implements MealDetailRemoteDataSource {
  @override
  Future<FoodResponseModel> fetchDetailById(String id) async {
    try {
      Map<String, dynamic> param = {'i': id};
      final response =
          await service.get(ServiceUrl.details, queryParameters: param);
      return MealsResponseModel.fromJson(response).meals!.first;
    } catch (e) {
      rethrow;
    }
  }
}
