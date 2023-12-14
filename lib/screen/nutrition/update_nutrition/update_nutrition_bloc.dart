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
    final result = state.data?.copyWith(
      protein: data.protein ?? state.data?.protein,
      totalFat: data.totalFat ?? state.data?.totalFat,
      cholesterol: data.cholesterol ?? state.data?.cholesterol,
      carbohydrate: data.carbohydrate ?? state.data?.carbohydrate,
      sugars: data.sugars ?? state.data?.sugars,
      dietaryFiber: data.dietaryFiber ?? state.data?.dietaryFiber,
      vitaminA: data.vitaminA ?? state.data?.vitaminA,
      vitaminB1: data.vitaminB1 ?? state.data?.vitaminB1,
      vitaminB2: data.vitaminB2 ?? state.data?.vitaminB2,
      vitaminB6: data.vitaminB6 ?? state.data?.vitaminB6,
      vitaminB9: data.vitaminB9 ?? state.data?.vitaminB9,
      vitaminB12: data.vitaminB12 ?? state.data?.vitaminB12,
      vitaminC: data.vitaminC ?? state.data?.vitaminC,
      vitaminD: data.vitaminD ?? state.data?.vitaminD,
      vitaminE: data.vitaminE ?? state.data?.vitaminE,
      vitaminK: data.vitaminK ?? state.data?.vitaminK,
      canxi: data.canxi ?? state.data?.canxi,
      phospho: data.phospho ?? state.data?.phospho,
      fe: data.fe ?? state.data?.fe,
      magie: data.magie ?? state.data?.magie,
      zn: data.zn ?? state.data?.zn,
      natri: data.natri ?? state.data?.natri,
      iod: data.iod ?? state.data?.iod,
      omega3: data.omega3 ?? state.data?.omega3,
      omega6: data.omega6 ?? state.data?.omega6,
      omega9: data.omega9 ?? state.data?.omega9,
    );
    emit(state.copyWith(
      data: result,
    ));
  }

  onSubmit() async {
    emit(state.copyWith(isUpdateSuccess: false));
    try {
      await _nutritionsRepository.patchNutritionById(
          id: state.id,
          request: UpdateNutritionRequest(
            protein: state.data?.protein,
            totalFat: state.data?.totalFat,
            cholesterol: state.data?.cholesterol,
            carbohydrate: state.data?.carbohydrate,
            sugars: state.data?.sugars,
            dietaryFiber: state.data?.dietaryFiber,
            vitaminA: state.data?.vitaminA,
            vitaminB1: state.data?.vitaminB1,
            vitaminB2: state.data?.vitaminB2,
            vitaminB6: state.data?.vitaminB6,
            vitaminB9: state.data?.vitaminB9,
            vitaminB12: state.data?.vitaminB12,
            vitaminC: state.data?.vitaminC,
            vitaminD: state.data?.vitaminD,
            vitaminE: state.data?.vitaminE,
            vitaminK: state.data?.vitaminK,
            canxi: state.data?.canxi,
            phospho: state.data?.phospho,
            fe: state.data?.fe,
            magie: state.data?.magie,
            zn: state.data?.zn,
            natri: state.data?.natri,
            iod: state.data?.iod,
            omega3: state.data?.omega3,
            omega6: state.data?.omega6,
            omega9: state.data?.omega9,
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
