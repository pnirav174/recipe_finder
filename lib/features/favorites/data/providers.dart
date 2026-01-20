import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../recipes/data/providers.dart';
import 'datasources/favorites_local_data_source.dart';
import 'repositories/favorites_repository.dart';

final favoritesLocalDataSourceProvider = Provider<FavoritesLocalDataSource>((
  ref,
) {
  final box = ref.watch(favoritesBoxProvider);
  return FavoritesLocalDataSourceImpl(box);
});

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final localDataSource = ref.watch(favoritesLocalDataSourceProvider);
  return FavoritesRepositoryImpl(localDataSource);
});
