import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:fitness_app_admin/repository/nutritions/models/nutrition_response/nutrition_response.dart';

part 'update_nutrition_state.g.dart';

@CopyWith()
class UpdateNutritionState {
  final String id;
  final bool isLoading;
  final NutritionResponse? data;
  final bool isUpdateSuccess;

  const UpdateNutritionState({
    this.id = '',
    this.isLoading = false,
    this.data,
    this.isUpdateSuccess = false,
  });
}
