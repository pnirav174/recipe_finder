import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class RecipeModel with _$RecipeModel {
  const factory RecipeModel({
    @JsonKey(name: 'idMeal') required String id,
    @JsonKey(name: 'strMeal') required String name,
    @JsonKey(name: 'strCategory') String? category,
    @JsonKey(name: 'strArea') String? area,
    @JsonKey(name: 'strInstructions') String? instructions,
    @JsonKey(name: 'strMealThumb') required String thumbUrl,
    @JsonKey(name: 'strYoutube') String? youtubeUrl,
    @JsonKey(name: 'strSource') String? sourceUrl,
    @Default([]) List<IngredientPair> ingredients,
  }) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    final ingredients = <IngredientPair>[];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients.add(
          IngredientPair(
            ingredient: ingredient.trim(),
            measure: measure?.trim() ?? '',
          ),
        );
      }
    }

    return RecipeModel(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String?,
      area: json['strArea'] as String?,
      instructions: json['strInstructions'] as String?,
      thumbUrl: json['strMealThumb'] as String,
      youtubeUrl: json['strYoutube'] as String?,
      sourceUrl: json['strSource'] as String?,
      ingredients: ingredients,
    );
  }
}

@freezed
class IngredientPair with _$IngredientPair {
  const factory IngredientPair({
    required String ingredient,
    required String measure,
  }) = _IngredientPair;

  factory IngredientPair.fromJson(Map<String, dynamic> json) =>
      _$IngredientPairFromJson(json);
}
