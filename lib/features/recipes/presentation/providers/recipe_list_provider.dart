import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/recipe_model.dart';
import '../../data/providers.dart';
import 'filter_provider.dart';

part 'recipe_list_provider.g.dart';

@riverpod
Future<List<RecipeModel>> recipeList(Ref ref) async {
  final repository = ref.watch(recipeRepositoryProvider);
  final filter = ref.watch(filterControllerProvider);

  List<RecipeModel> recipes = [];

  // Fetch initial data based on primary filter
  if (filter.query.isNotEmpty) {
    recipes = await repository.searchRecipes(filter.query);
  } else if (filter.category != null) {
    recipes = await repository.filterByCategory(filter.category!);
  } else if (filter.area != null) {
    recipes = await repository.filterByArea(filter.area!);
  } else {
    recipes = await repository.searchRecipes('');
  }

  // Refine results locally if we have full details from search
  if (filter.query.isNotEmpty) {
    if (filter.category != null) {
      recipes = recipes.where((r) => r.category == filter.category).toList();
    }
    if (filter.area != null) {
      recipes = recipes.where((r) => r.area == filter.area).toList();
    }
  }

  // Sorting
  recipes.sort((a, b) {
    final cmp = a.name.compareTo(b.name);
    return filter.sortAscending ? cmp : -cmp;
  });

  return recipes;
}
