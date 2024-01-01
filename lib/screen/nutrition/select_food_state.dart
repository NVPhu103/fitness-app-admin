import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:fitness_app_admin/repository/foods/models/food_response/food_response.dart';

part 'select_food_state.g.dart';

@CopyWith()
class SelectFoodState {
  final List<FoodResponse>? dataList;
  final int currentPage;
  final bool canLoadMore;

  const SelectFoodState({
    this.dataList,
    this.currentPage = 1,
    this.canLoadMore = false,
  });
}
