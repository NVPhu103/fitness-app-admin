import 'package:fitness_app_admin/repository/foods/foods_repository.dart';
import 'package:fitness_app_admin/repository/foods/models/food_response/food_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'select_food_state.dart';

class SelectFoodBloc extends Cubit<SelectFoodState> {
  final FoodsRepository _foodsRepository = FoodsRepository();
  SelectFoodBloc() : super(const SelectFoodState());

  onFetch({
    required int page,
  }) async {
    try {
      if (page == 1) {
        emit(
          state.copyWith(
            canLoadMore: false,
          ),
        );
      }
      final data = await _foodsRepository.filterFoodList(
        page: page,
      );

      var newDataList = List<FoodResponse>.from(data.data ?? []);

      final maxLoadMore = ((data.totalPages ?? 0) / 10).floor();

      final canLoadMore = page <= maxLoadMore;

      emit(state.copyWith(
        dataList: newDataList,
        currentPage: page,
        canLoadMore: canLoadMore,
      ));
    } catch (error, statckTrace) {
      if (kDebugMode) {
        print("$error + $statckTrace");
      }
    }
  }
}
