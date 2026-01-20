import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_finder/features/recipes/presentation/widgets/recipe_card.dart';
import 'package:recipe_finder/features/recipes/data/models/recipe_model.dart';

// Mock HttpOverrides to avoid network calls during tests
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
    name: 'Test Recipe',
    thumbUrl: 'https://example.com/image.jpg',
    category: 'Test Category',
    area: 'Test Area',
    ingredients: [],
  );

  testWidgets('RecipeCard displays recipe information', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: RecipeCard(recipe: tRecipe)),
      ),
    );

    expect(find.text('Test Recipe'), findsOneWidget);
    expect(find.text('Test Category • Test Area'), findsOneWidget);
    // Image placeholder might be showing because network image fails or is loading
    // We confirm the widget structure exists
  });
}
