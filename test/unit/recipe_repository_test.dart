import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder/features/recipes/data/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipes/data/datasources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipes/data/datasources/recipe_cache_data_source.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe_model.dart';

class MockRemoteDataSource extends Mock implements RecipeRemoteDataSource {}

class MockCacheDataSource extends Mock implements RecipeCacheDataSource {}

void main() {
  late RecipeRepository repository;
  late MockRemoteDataSource remoteDataSource;

  late MockCacheDataSource cacheDataSource;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    cacheDataSource = MockCacheDataSource();
    repository = RecipeRepository(remoteDataSource, cacheDataSource);

    registerFallbackValue(
      RecipeModel(id: '1', name: 'Test', thumbUrl: 'url', ingredients: []),
    );
  });

  const tRecipeId = '1';
  final tRecipe = RecipeModel(
    id: tRecipeId,
    name: 'Test Recipe',
    thumbUrl: 'test_url',
    instructions: 'Test Instructions',
    category: 'Test Category',
    area: 'Test Area',
    ingredients: [],
  );

  group('getRecipeById', () {
    test(
      'should return recipe from remote and cache it when remote call is successful',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRecipeById(tRecipeId),
        ).thenAnswer((_) async => tRecipe);
        when(() => cacheDataSource.cacheRecipe(any())).thenAnswer((_) async {});

        // Act
        final result = await repository.getRecipeById(tRecipeId);

        // Assert
        expect(result, equals(tRecipe));
        verify(() => remoteDataSource.getRecipeById(tRecipeId)).called(1);
        verify(() => cacheDataSource.cacheRecipe(tRecipe)).called(1);
      },
    );

    test(
      'should return cached recipe when remote call fails and cache has data',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getRecipeById(tRecipeId),
        ).thenThrow(Exception('Server Error'));
        when(
          () => cacheDataSource.getCachedRecipe(tRecipeId),
        ).thenReturn(tRecipe);

        // Act
        final result = await repository.getRecipeById(tRecipeId);

        // Assert
        expect(result, equals(tRecipe));
        verify(() => remoteDataSource.getRecipeById(tRecipeId)).called(1);
        verify(() => cacheDataSource.getCachedRecipe(tRecipeId)).called(1);
      },
    );

    test('should throw exception when both remote and cache fail', () async {
      // Arrange
      when(
        () => remoteDataSource.getRecipeById(tRecipeId),
      ).thenThrow(Exception('Server Error'));
      when(() => cacheDataSource.getCachedRecipe(tRecipeId)).thenReturn(null);

      // Act
      final call = repository.getRecipeById;

      // Assert
      expect(() => call(tRecipeId), throwsException);
    });
  });
}
