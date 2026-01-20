import 'package:hive_flutter/hive_flutter.dart';
import '../../../../features/recipes/data/models/recipe_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<RecipeModel>> getFavorites();
  Stream<List<RecipeModel>> watchFavorites();
  Future<void> addFavorite(RecipeModel recipe);
  Future<void> removeFavorite(String recipeId);
  bool isFavorite(String recipeId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<RecipeModel> favoritesBox;

  FavoritesLocalDataSourceImpl(this.favoritesBox);

  @override
  Future<List<RecipeModel>> getFavorites() async {
    return favoritesBox.values.toList();
  }

  @override
  Stream<List<RecipeModel>> watchFavorites() async* {
    // Yield preliminary values
    yield favoritesBox.values.toList();

    // Yield on changes
    await for (final _ in favoritesBox.watch()) {
      yield favoritesBox.values.toList();
    }
  }

  @override
  Future<void> addFavorite(RecipeModel recipe) async {
    await favoritesBox.put(recipe.id, recipe);
  }

  @override
  Future<void> removeFavorite(String recipeId) async {
    await favoritesBox.delete(recipeId);
  }

  @override
  bool isFavorite(String recipeId) {
    return favoritesBox.containsKey(recipeId);
  }
}
