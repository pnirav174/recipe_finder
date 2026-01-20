import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/recipes/presentation/pages/recipe_list_page.dart';
import '../features/recipes/presentation/pages/recipe_detail_page.dart';
import '../features/favorites/presentation/pages/favorites_page.dart';
import '../features/recipes/data/models/recipe_model.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RecipeListPage(),
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final initialRecipe = state.extra as RecipeModel?;
            return RecipeDetailPage(recipeId: id, initialRecipe: initialRecipe);
          },
        ),
        GoRoute(
          path: 'favorites',
          builder: (context, state) => const FavoritesPage(),
        ),
      ],
    ),
  ],
);
