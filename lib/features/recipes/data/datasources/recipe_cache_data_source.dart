import 'package:hive/hive.dart';
import '../models/recipe_model.dart';

class RecipeCacheDataSource {
  final Box<RecipeModel> _box;

  RecipeCacheDataSource(this._box);

  Future<void> cacheRecipe(RecipeModel recipe) async {
    await _box.put(recipe.id, recipe);
  }

  RecipeModel? getCachedRecipe(String id) {
    return _box.get(id);
  }
}
