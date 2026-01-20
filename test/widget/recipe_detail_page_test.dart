import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe_model.dart';
import 'package:recipe_finder/features/recipes/presentation/pages/recipe_detail_page.dart';
import 'package:recipe_finder/features/favorites/data/repositories/favorites_repository.dart';
import 'package:recipe_finder/features/favorites/data/providers.dart';
import 'package:recipe_finder/features/recipes/presentation/providers/recipe_detail_provider.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

// Mock HttpOverrides
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
    registerFallbackValue(
      const RecipeModel(
        id: 'fallback',
        name: 'Fallback',
        thumbUrl: 'url',
        ingredients: [],
      ),
    );
  });

  const tRecipe = RecipeModel(
    id: '1',
    name: 'Test Recipe',
    thumbUrl: 'https://example.com/image.jpg',
    ingredients: [],
    instructions: 'Mix it.',
    category: 'Dessert',
    area: 'French',
  );

  testWidgets('RecipeDetailPage shows recipe info and toggles favorite', (
    WidgetTester tester,
  ) async {
    final mockRepo = MockFavoritesRepository();
    when(() => mockRepo.watchFavorites()).thenAnswer((_) => Stream.value([]));
    when(() => mockRepo.isFavorite(any())).thenReturn(false);
    when(() => mockRepo.toggleFavorite(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(mockRepo),
          recipeDetailProvider(
            '1',
          ).overrideWith((ref) => Future.value(tRecipe)),
        ],
        child: const MaterialApp(
          home: RecipeDetailPage(recipeId: '1', initialRecipe: tRecipe),
        ),
      ),
    );

    await tester.pump(
      const Duration(seconds: 1),
    ); // Wait for images/state, but don't wait for infinite animations

    expect(find.text('Test Recipe'), findsOneWidget);

    // Test favorite toggle
    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);

    await tester.tap(fab);

    verify(() => mockRepo.toggleFavorite(tRecipe)).called(1);
  });
}
