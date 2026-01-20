import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe_model.dart';
import 'package:recipe_finder/features/recipes/presentation/pages/recipe_list_page.dart';
import 'package:recipe_finder/features/recipes/presentation/providers/recipe_list_provider.dart';

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
  });

  const tRecipe = RecipeModel(
    id: '1',
    name: 'Pancakes',
    thumbUrl: 'https://example.com/pancakes.jpg',
    category: 'Breakfast',
    area: 'American',
    ingredients: [],
  );

  testWidgets('RecipeListPage shows recipe list', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          recipeListProvider.overrideWith((ref) => Future.value([tRecipe])),
        ],
        child: const MaterialApp(home: RecipeListPage()),
      ),
    );

    // Initial pump
    await tester.pump();
    // Wait for async value
    await tester.pump();

    expect(find.text('Pancakes'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('RecipeListPage shows empty state', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [recipeListProvider.overrideWith((ref) => Future.value([]))],
        child: const MaterialApp(home: RecipeListPage()),
      ),
    );

    await tester.pump();
    await tester.pump();

    expect(find.text('No recipes found'), findsOneWidget);
  });
}
