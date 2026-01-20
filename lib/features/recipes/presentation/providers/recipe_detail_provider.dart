import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/recipe_model.dart';
import '../../data/providers.dart';

part 'recipe_detail_provider.g.dart';

@riverpod
Future<RecipeModel?> recipeDetail(Ref ref, String id) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.getRecipeById(id);
}
