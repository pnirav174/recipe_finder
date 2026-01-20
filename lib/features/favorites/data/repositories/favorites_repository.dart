import '../../../../features/recipes/data/models/recipe_model.dart';
import '../datasources/favorites_local_data_source.dart';

abstract class FavoritesRepository {
  Stream<List<RecipeModel>> watchFavorites();
  Future<void> addFavorite(RecipeModel recipe);
  Future<void> removeFavorite(String recipeId);
  Future<void> toggleFavorite(RecipeModel recipe);
  bool isFavorite(String recipeId);
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource _localDataSource;

  FavoritesRepositoryImpl(this._localDataSource);

  @override
  Stream<List<RecipeModel>> watchFavorites() {
    return _localDataSource.watchFavorites();
  }

  @override
  Future<void> addFavorite(RecipeModel recipe) async {
    await _localDataSource.addFavorite(recipe);
  }

  @override
  Future<void> removeFavorite(String recipeId) async {
    await _localDataSource.removeFavorite(recipeId);
  }

  @override
  Future<void> toggleFavorite(RecipeModel recipe) async {
    if (_localDataSource.isFavorite(recipe.id)) {
      await _localDataSource.removeFavorite(recipe.id);
    } else {
      await _localDataSource.addFavorite(recipe);
    }
  }

  @override
  bool isFavorite(String recipeId) {
    return _localDataSource.isFavorite(recipeId);
  }
}
