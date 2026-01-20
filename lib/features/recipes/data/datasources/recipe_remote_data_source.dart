import '../../../../core/network/api_client.dart';
import '../models/recipe_model.dart';
import '../models/category_model.dart';
import '../models/area_model.dart';

class RecipeRemoteDataSource {
  final ApiClient _apiClient;

  RecipeRemoteDataSource(this._apiClient);

  Future<List<RecipeModel>> searchRecipes(String query) async {
    final response = await _apiClient.get(
      '/search.php',
      queryParameters: {'s': query},
    );
    if (response['meals'] == null) return [];
    return (response['meals'] as List)
        .map((e) => RecipeModel.fromJson(e))
        .toList();
  }

  Future<RecipeModel?> getRecipeById(String id) async {
    final response = await _apiClient.get(
      '/lookup.php',
      queryParameters: {'i': id},
    );
    if (response['meals'] == null || (response['meals'] as List).isEmpty)
      return null;
    return RecipeModel.fromJson(response['meals'][0]);
  }

  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiClient.get('/categories.php');
    if (response['categories'] == null) return [];
    return (response['categories'] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  Future<List<AreaModel>> getAreas() async {
    final response = await _apiClient.get(
      '/list.php',
      queryParameters: {'a': 'list'},
    );
    if (response['meals'] == null) return [];
    return (response['meals'] as List)
        .map((e) => AreaModel.fromJson(e))
        .toList();
  }

  Future<List<RecipeModel>> filterByCategory(String category) async {
    final response = await _apiClient.get(
      '/filter.php',
      queryParameters: {'c': category},
    );
    if (response['meals'] == null) return [];
    // Filter endpoints return partial data (ID, name, thumbnail).
    // Detailed info is fetched on demand via getRecipeById.
    return (response['meals'] as List)
        .map((e) => RecipeModel.fromJson(e))
        .toList();
  }

  Future<List<RecipeModel>> filterByArea(String area) async {
    final response = await _apiClient.get(
      '/filter.php',
      queryParameters: {'a': area},
    );
    if (response['meals'] == null) return [];
    return (response['meals'] as List)
        .map((e) => RecipeModel.fromJson(e))
        .toList();
  }
}
