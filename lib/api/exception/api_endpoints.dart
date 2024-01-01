const baseUrl = "https://fitness-app-e0xl.onrender.com";

class FoodsApi {
  static const filterFoodList =
      "/foods?status=ACTIVE&page={page}&per_page=10&sort=name:asc";
}

class NutritionsApi {
  static const nutritionById = "/nutritions/{id}";
}
