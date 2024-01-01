import 'food_response.dart';

class FilterFoodListResponse {
  int? totalPages;
  List<FoodResponse>? data;

  FilterFoodListResponse({
    this.totalPages,
    this.data,
  });
}
