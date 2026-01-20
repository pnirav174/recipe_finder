import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder/features/favorites/data/repositories/favorites_repository.dart';
import 'package:recipe_finder/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe_model.dart';

class MockFavoritesLocalDataSource extends Mock
    implements FavoritesLocalDataSource {}

void main() {
  late FavoritesRepository repository;
  late MockFavoritesLocalDataSource localDataSource;

  setUp(() {
    localDataSource = MockFavoritesLocalDataSource();
    repository = FavoritesRepositoryImpl(localDataSource);

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

  group('FavoritesRepository', () {
    test(
      'getFavorites (via watch) should return stream from local data source',
      () {
        // Arrange
        when(
          () => localDataSource.watchFavorites(),
        ).thenAnswer((_) => Stream.value([tRecipe]));

        // Act
        final result = repository.watchFavorites();

        // Assert
        expect(result, emits([tRecipe]));
        verify(() => localDataSource.watchFavorites()).called(1);
      },
    );

    test('addFavorite should call local data source', () async {
      // Arrange
      when(() => localDataSource.addFavorite(any())).thenAnswer((_) async {});

      // Act
      await repository.addFavorite(tRecipe);

      // Assert
      verify(() => localDataSource.addFavorite(tRecipe)).called(1);
    });

    test('removeFavorite should call local data source', () async {
      // Arrange
      when(
        () => localDataSource.removeFavorite(any()),
      ).thenAnswer((_) async {});

      // Act
      await repository.removeFavorite(tRecipeId);

      // Assert
      verify(() => localDataSource.removeFavorite(tRecipeId)).called(1);
    });

    test('toggleFavorite should add if not favorite', () async {
      // Arrange
      when(() => localDataSource.isFavorite(tRecipeId)).thenReturn(false);
      when(() => localDataSource.addFavorite(any())).thenAnswer((_) async {});

      // Act
      await repository.toggleFavorite(tRecipe);

      // Assert
      verify(() => localDataSource.addFavorite(tRecipe)).called(1);
      verifyNever(() => localDataSource.removeFavorite(any()));
    });

    test('toggleFavorite should remove if favorite', () async {
      // Arrange
      when(() => localDataSource.isFavorite(tRecipeId)).thenReturn(true);
      when(
        () => localDataSource.removeFavorite(any()),
      ).thenAnswer((_) async {});

      // Act
      await repository.toggleFavorite(tRecipe);

      // Assert
      verify(() => localDataSource.removeFavorite(tRecipeId)).called(1);
      verifyNever(() => localDataSource.addFavorite(any()));
    });
  });
}
