import 'package:food/core/network/base_dio_service.dart';
import 'package:food/core/network/service_url.dart';
import 'package:food/core/utils/function.dart';
import 'package:food/feature/food/list/data/models/meals_response/meal_response.dart';

abstract class MealsRemoteDataSource {
  Future<MealsResponseModel> fetchMeals();
}

class MealsRemoteDataSourceImpl extends BaseServiceDio
    implements MealsRemoteDataSource {
  @override
  Future<MealsResponseModel> fetchMeals() async {
    try {
      Map<String, dynamic> param = {'f': generateRandomString()};
      final response =
          await service.get(ServiceUrl.list, queryParameters: param);
      return MealsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
