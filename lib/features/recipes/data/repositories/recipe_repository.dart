import '../datasources/recipe_remote_data_source.dart';
import '../datasources/recipe_cache_data_source.dart';
import '../models/recipe_model.dart';
import '../models/category_model.dart';
import '../models/area_model.dart';

class RecipeRepository {
  final RecipeRemoteDataSource _remoteDataSource;
  final RecipeCacheDataSource _cacheDataSource;

  RecipeRepository(this._remoteDataSource, this._cacheDataSource);

  Future<List<RecipeModel>> searchRecipes(String query) async {
    return _remoteDataSource.searchRecipes(query);
  }

  Future<RecipeModel> getRecipeById(String id) async {
    try {
      final recipe = await _remoteDataSource.getRecipeById(id);
      if (recipe == null) {
        throw Exception('Recipe not found');
      }
      await _cacheDataSource.cacheRecipe(recipe);
      return recipe;
    } catch (e) {
      final cached = _cacheDataSource.getCachedRecipe(id);
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    return _remoteDataSource.getCategories();
  }

  Future<List<AreaModel>> getAreas() async {
    return _remoteDataSource.getAreas();
  }

  Future<List<RecipeModel>> filterByCategory(String category) {
    return _remoteDataSource.filterByCategory(category);
  }

  Future<List<RecipeModel>> filterByArea(String area) {
    return _remoteDataSource.filterByArea(area);
  }
}
