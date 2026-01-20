import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants.dart';
import '../../../core/network/api_client.dart';

import 'datasources/recipe_cache_data_source.dart';
import 'datasources/recipe_remote_data_source.dart';
import 'repositories/recipe_repository.dart';
import 'models/category_model.dart';
import 'models/area_model.dart';
import 'models/recipe_model.dart';

part 'providers.g.dart';

// Dio / ApiClient
@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

// Hive Box
@riverpod
Box<RecipeModel> favoritesBox(Ref ref) {
  return Hive.box<RecipeModel>(AppConstants.favoritesBox);
}

// Data Sources
@riverpod
RecipeRemoteDataSource recipeRemoteDataSource(Ref ref) {
  return RecipeRemoteDataSource(ref.watch(apiClientProvider));
}

@riverpod
Box<RecipeModel> recipeCacheBox(Ref ref) {
  throw UnimplementedError('recipeCacheBox must be overridden in main');
}

@riverpod
RecipeCacheDataSource recipeCacheDataSource(Ref ref) {
  final box = ref.watch(recipeCacheBoxProvider);
  return RecipeCacheDataSource(box);
}

// Repository
@riverpod
RecipeRepository recipeRepository(Ref ref) {
  final remote = ref.watch(recipeRemoteDataSourceProvider);
  final cache = ref.watch(recipeCacheDataSourceProvider);
  return RecipeRepository(remote, cache);
}

@riverpod
Future<List<CategoryModel>> categories(Ref ref) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.getCategories();
}

@riverpod
Future<List<AreaModel>> areas(Ref ref) async {
  final repository = ref.watch(recipeRepositoryProvider);
  return repository.getAreas();
}
