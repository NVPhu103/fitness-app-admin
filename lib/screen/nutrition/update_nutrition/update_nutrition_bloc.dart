import 'package:fitness_app_admin/api/services/nutritions/models/update_nutrition/update_nutrition_request.dart';
import 'package:fitness_app_admin/repository/nutritions/models/nutrition_response/nutrition_response.dart';
import 'package:fitness_app_admin/repository/nutritions/nutritions_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_nutrition_state.dart';

class UpdateNutritionBloc extends Cubit<UpdateNutritionState> {
  final _nutritionsRepository = NutritionsRepository();
  UpdateNutritionBloc() : super(const UpdateNutritionState());

  getData(String id) async {
    emit(state.copyWith(isLoading: true));
    try {
      final data = await _nutritionsRepository.getNutritionById(
        id: id,
      );

      emit(state.copyWith(id: id, data: data, isLoading: false));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }

  onChangeData(UpdateNutritionRequest data) {
    if (state.data != null) {
      emit(state.copyWith(
        data: state.data?.copyWith(
          protein: data.protein,
          totalFat: data.protein,
          cholesterol: data.protein,
          carbohydrate: data.protein,
          sugars: data.protein,
          dietaryFiber: data.protein,
          vitaminA: data.protein,
          vitaminB1: data.protein,
          vitaminB2: data.protein,
          vitaminB6: data.protein,
          vitaminB9: data.protein,
          vitaminB12: data.protein,
          vitaminC: data.protein,
          vitaminD: data.protein,
          vitaminE: data.protein,
          vitaminK: data.protein,
          canxi: data.protein,
          phospho: data.protein,
          fe: data.protein,
          magie: data.protein,
          zn: data.protein,
          natri: data.protein,
          iod: data.protein,
          omega3: data.protein,
          omega6: data.protein,
          omega9: data.protein,
        ),
      ));
    }
  }

  onSubmit() async {
    emit(state.copyWith(isUpdateSuccess: false));
    try {
      await _nutritionsRepository.patchNutritionById(
          id: state.id,
          request: UpdateNutritionRequest(
            protein: state.data?.protein,
            totalFat: state.data?.protein,
            cholesterol: state.data?.protein,
            carbohydrate: state.data?.protein,
            sugars: state.data?.protein,
            dietaryFiber: state.data?.protein,
            vitaminA: state.data?.protein,
            vitaminB1: state.data?.protein,
            vitaminB2: state.data?.protein,
            vitaminB6: state.data?.protein,
            vitaminB9: state.data?.protein,
            vitaminB12: state.data?.protein,
            vitaminC: state.data?.protein,
            vitaminD: state.data?.protein,
            vitaminE: state.data?.protein,
            vitaminK: state.data?.protein,
            canxi: state.data?.protein,
            phospho: state.data?.protein,
            fe: state.data?.protein,
            magie: state.data?.protein,
            zn: state.data?.protein,
            natri: state.data?.protein,
            iod: state.data?.protein,
            omega3: state.data?.protein,
            omega6: state.data?.protein,
            omega9: state.data?.protein,
          ));

      emit(state.copyWith(
        isUpdateSuccess: true,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    } finally {
      emit(state.copyWith(
        isUpdateSuccess: false,
      ));
    }
  }
}
