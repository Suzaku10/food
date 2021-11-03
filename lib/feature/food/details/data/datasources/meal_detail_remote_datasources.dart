import 'package:food/core/network/base_dio_service.dart';
import 'package:food/core/network/service_url.dart';
import 'package:food/feature/food/list/data/models/food_response/food_response_model.dart';

abstract class MealDetailRemoteDataSource {
  Future<FoodResponseModel> fetchDetailById(String id);
}

class MealsRemoteDataSourceImpl extends BaseServiceDio
    implements MealDetailRemoteDataSource {
  @override
  Future<FoodResponseModel> fetchDetailById(String id) async {
    try {
      final response = await service.get(ServiceUrl.details);
      return FoodResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
