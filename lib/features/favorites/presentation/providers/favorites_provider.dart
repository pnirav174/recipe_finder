import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../recipes/data/models/recipe_model.dart';
import '../../data/providers.dart';

final favoritesProvider = StreamProvider<List<RecipeModel>>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return repository.watchFavorites();
});
