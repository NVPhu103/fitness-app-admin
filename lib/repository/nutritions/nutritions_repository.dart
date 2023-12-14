import 'package:fitness_app_admin/api/services/nutritions/models/update_nutrition/update_nutrition_request.dart';
import 'package:fitness_app_admin/api/services/nutritions/nutritions_service.dart';
import 'package:flutter/foundation.dart';

import 'models/nutrition_response/nutrition_response.dart';

class NutritionsRepository {
  final _service = NutritionsService();

  Future<NutritionResponse> getNutritionById({
    required String id,
  }) async {
    try {
      final response = await _service.getNutritionById(
        id: id,
      );
      if (response.statusCode == 200) {
        final result = NutritionResponse.fromJson(response.data);
        return result;
      } else {
        return NutritionResponse();
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return NutritionResponse();
    }
  }

  Future<void> patchNutritionById({
    required String id,
    required UpdateNutritionRequest request,
  }) async {
    try {
      await _service.patchNutritionById(
        id: id,
        request: request,
      );
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }
}
