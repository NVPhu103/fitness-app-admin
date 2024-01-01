import 'package:fitness_app_admin/api/services/foods/foods_service.dart';
import 'package:flutter/foundation.dart';

import 'models/food_response/filter_food_list_response.dart';
import 'models/food_response/food_response.dart';

class FoodsRepository {
  final _service = FoodsService();

  Future<FilterFoodListResponse> filterFoodList({
    required int page,
  }) async {
    try {
      final response = await _service.filterFoodList(
        page: page.toString(),
      );
      if (response.statusCode == 200) {
        final totalPages = response.headers['total-record'];
        final data = FoodResponse.fromJsonArray(response.data);
        return FilterFoodListResponse(
          totalPages: totalPages != null ? int.parse(totalPages[0]) : 0,
          data: data,
        );
      } else {
        return FilterFoodListResponse();
      }
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
      return FilterFoodListResponse();
    }
  }
}
