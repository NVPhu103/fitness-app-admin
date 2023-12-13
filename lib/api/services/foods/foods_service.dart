import 'package:dio/dio.dart';
import 'package:fitness_app_admin/api/exception/api_endpoints.dart';
import 'package:fitness_app_admin/base/base_service.dart';

class FoodsService extends BaseService {
  Future<Response> filterFoodList({
    required String page,
  }) async {
    final response = await get(
      FoodsApi.filterFoodList.replaceAll(RegExp('{page}'), page),
    );
    return response;
  }
}
