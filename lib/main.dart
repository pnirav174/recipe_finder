import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/app_theme.dart';
import 'core/constants.dart';
import 'core/router.dart';
import 'features/recipes/data/models/recipe_model.dart';
import 'features/recipes/data/models/recipe_model_adapter.dart';
import 'features/recipes/data/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(RecipeModelAdapter());
  Hive.registerAdapter(IngredientPairAdapter());

  // Open Hive box for favorites
  final favoritesBox = await Hive.openBox<RecipeModel>(
    AppConstants.favoritesBox,
  );
  // Open Hive box for cache
  final cacheBox = await Hive.openBox<RecipeModel>('recipe_cache');

  runApp(
    ProviderScope(
      overrides: [
        favoritesBoxProvider.overrideWithValue(favoritesBox),
        recipeCacheBoxProvider.overrideWithValue(cacheBox),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recipe Finder',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
