import 'package:dio/dio.dart';
import 'package:fitness_app_admin/api/exception/api_endpoints.dart';
import 'package:fitness_app_admin/base/base_service.dart';

import 'models/update_nutrition/update_nutrition_request.dart';

class NutritionsService extends BaseService {
  Future<Response> getNutritionById({
    required String id,
  }) async {
    final response = await get(
      NutritionsApi.nutritionById.replaceAll(RegExp('{id}'), id),
    );
    return response;
  }

  Future<Response> patchNutritionById({
    required String id,
    required UpdateNutritionRequest request,
  }) async {
    final response = await patch(
      NutritionsApi.nutritionById.replaceAll(RegExp('{id}'), id),
      data: request.toJson(),
    );
    return response;
  }
}
