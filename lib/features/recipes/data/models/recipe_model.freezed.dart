// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecipeModel {
  @JsonKey(name: 'idMeal')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'strMeal')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'strCategory')
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'strArea')
  String? get area => throw _privateConstructorUsedError;
  @JsonKey(name: 'strInstructions')
  String? get instructions => throw _privateConstructorUsedError;
  @JsonKey(name: 'strMealThumb')
  String get thumbUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'strYoutube')
  String? get youtubeUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'strSource')
  String? get sourceUrl => throw _privateConstructorUsedError;
  List<IngredientPair> get ingredients => throw _privateConstructorUsedError;

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeModelCopyWith<RecipeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeModelCopyWith<$Res> {
  factory $RecipeModelCopyWith(
    RecipeModel value,
    $Res Function(RecipeModel) then,
  ) = _$RecipeModelCopyWithImpl<$Res, RecipeModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'idMeal') String id,
    @JsonKey(name: 'strMeal') String name,
    @JsonKey(name: 'strCategory') String? category,
    @JsonKey(name: 'strArea') String? area,
    @JsonKey(name: 'strInstructions') String? instructions,
    @JsonKey(name: 'strMealThumb') String thumbUrl,
    @JsonKey(name: 'strYoutube') String? youtubeUrl,
    @JsonKey(name: 'strSource') String? sourceUrl,
    List<IngredientPair> ingredients,
  });
}

/// @nodoc
class _$RecipeModelCopyWithImpl<$Res, $Val extends RecipeModel>
    implements $RecipeModelCopyWith<$Res> {
  _$RecipeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? area = freezed,
    Object? instructions = freezed,
    Object? thumbUrl = null,
    Object? youtubeUrl = freezed,
    Object? sourceUrl = freezed,
    Object? ingredients = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            area: freezed == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as String?,
            instructions: freezed == instructions
                ? _value.instructions
                : instructions // ignore: cast_nullable_to_non_nullable
                      as String?,
            thumbUrl: null == thumbUrl
                ? _value.thumbUrl
                : thumbUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            youtubeUrl: freezed == youtubeUrl
                ? _value.youtubeUrl
                : youtubeUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            sourceUrl: freezed == sourceUrl
                ? _value.sourceUrl
                : sourceUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            ingredients: null == ingredients
                ? _value.ingredients
                : ingredients // ignore: cast_nullable_to_non_nullable
                      as List<IngredientPair>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipeModelImplCopyWith<$Res>
    implements $RecipeModelCopyWith<$Res> {
  factory _$$RecipeModelImplCopyWith(
    _$RecipeModelImpl value,
    $Res Function(_$RecipeModelImpl) then,
  ) = __$$RecipeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'idMeal') String id,
    @JsonKey(name: 'strMeal') String name,
    @JsonKey(name: 'strCategory') String? category,
    @JsonKey(name: 'strArea') String? area,
    @JsonKey(name: 'strInstructions') String? instructions,
    @JsonKey(name: 'strMealThumb') String thumbUrl,
    @JsonKey(name: 'strYoutube') String? youtubeUrl,
    @JsonKey(name: 'strSource') String? sourceUrl,
    List<IngredientPair> ingredients,
  });
}

/// @nodoc
class __$$RecipeModelImplCopyWithImpl<$Res>
    extends _$RecipeModelCopyWithImpl<$Res, _$RecipeModelImpl>
    implements _$$RecipeModelImplCopyWith<$Res> {
  __$$RecipeModelImplCopyWithImpl(
    _$RecipeModelImpl _value,
    $Res Function(_$RecipeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? area = freezed,
    Object? instructions = freezed,
    Object? thumbUrl = null,
    Object? youtubeUrl = freezed,
    Object? sourceUrl = freezed,
    Object? ingredients = null,
  }) {
    return _then(
      _$RecipeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as String?,
        instructions: freezed == instructions
            ? _value.instructions
            : instructions // ignore: cast_nullable_to_non_nullable
                  as String?,
        thumbUrl: null == thumbUrl
            ? _value.thumbUrl
            : thumbUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        youtubeUrl: freezed == youtubeUrl
            ? _value.youtubeUrl
            : youtubeUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        sourceUrl: freezed == sourceUrl
            ? _value.sourceUrl
            : sourceUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        ingredients: null == ingredients
            ? _value._ingredients
            : ingredients // ignore: cast_nullable_to_non_nullable
                  as List<IngredientPair>,
      ),
    );
  }
}

/// @nodoc

class _$RecipeModelImpl implements _RecipeModel {
  const _$RecipeModelImpl({
    @JsonKey(name: 'idMeal') required this.id,
    @JsonKey(name: 'strMeal') required this.name,
    @JsonKey(name: 'strCategory') this.category,
    @JsonKey(name: 'strArea') this.area,
    @JsonKey(name: 'strInstructions') this.instructions,
    @JsonKey(name: 'strMealThumb') required this.thumbUrl,
    @JsonKey(name: 'strYoutube') this.youtubeUrl,
    @JsonKey(name: 'strSource') this.sourceUrl,
    final List<IngredientPair> ingredients = const [],
  }) : _ingredients = ingredients;

  @override
  @JsonKey(name: 'idMeal')
  final String id;
  @override
  @JsonKey(name: 'strMeal')
  final String name;
  @override
  @JsonKey(name: 'strCategory')
  final String? category;
  @override
  @JsonKey(name: 'strArea')
  final String? area;
  @override
  @JsonKey(name: 'strInstructions')
  final String? instructions;
  @override
  @JsonKey(name: 'strMealThumb')
  final String thumbUrl;
  @override
  @JsonKey(name: 'strYoutube')
  final String? youtubeUrl;
  @override
  @JsonKey(name: 'strSource')
  final String? sourceUrl;
  final List<IngredientPair> _ingredients;
  @override
  @JsonKey()
  List<IngredientPair> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  String toString() {
    return 'RecipeModel(id: $id, name: $name, category: $category, area: $area, instructions: $instructions, thumbUrl: $thumbUrl, youtubeUrl: $youtubeUrl, sourceUrl: $sourceUrl, ingredients: $ingredients)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.thumbUrl, thumbUrl) ||
                other.thumbUrl == thumbUrl) &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                other.youtubeUrl == youtubeUrl) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            const DeepCollectionEquality().equals(
              other._ingredients,
              _ingredients,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    area,
    instructions,
    thumbUrl,
    youtubeUrl,
    sourceUrl,
    const DeepCollectionEquality().hash(_ingredients),
  );

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      __$$RecipeModelImplCopyWithImpl<_$RecipeModelImpl>(this, _$identity);
}

abstract class _RecipeModel implements RecipeModel {
  const factory _RecipeModel({
    @JsonKey(name: 'idMeal') required final String id,
    @JsonKey(name: 'strMeal') required final String name,
    @JsonKey(name: 'strCategory') final String? category,
    @JsonKey(name: 'strArea') final String? area,
    @JsonKey(name: 'strInstructions') final String? instructions,
    @JsonKey(name: 'strMealThumb') required final String thumbUrl,
    @JsonKey(name: 'strYoutube') final String? youtubeUrl,
    @JsonKey(name: 'strSource') final String? sourceUrl,
    final List<IngredientPair> ingredients,
  }) = _$RecipeModelImpl;

  @override
  @JsonKey(name: 'idMeal')
  String get id;
  @override
  @JsonKey(name: 'strMeal')
  String get name;
  @override
  @JsonKey(name: 'strCategory')
  String? get category;
  @override
  @JsonKey(name: 'strArea')
  String? get area;
  @override
  @JsonKey(name: 'strInstructions')
  String? get instructions;
  @override
  @JsonKey(name: 'strMealThumb')
  String get thumbUrl;
  @override
  @JsonKey(name: 'strYoutube')
  String? get youtubeUrl;
  @override
  @JsonKey(name: 'strSource')
  String? get sourceUrl;
  @override
  List<IngredientPair> get ingredients;

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IngredientPair _$IngredientPairFromJson(Map<String, dynamic> json) {
  return _IngredientPair.fromJson(json);
}

/// @nodoc
mixin _$IngredientPair {
  String get ingredient => throw _privateConstructorUsedError;
  String get measure => throw _privateConstructorUsedError;

  /// Serializes this IngredientPair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IngredientPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IngredientPairCopyWith<IngredientPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IngredientPairCopyWith<$Res> {
  factory $IngredientPairCopyWith(
    IngredientPair value,
    $Res Function(IngredientPair) then,
  ) = _$IngredientPairCopyWithImpl<$Res, IngredientPair>;
  @useResult
  $Res call({String ingredient, String measure});
}

/// @nodoc
class _$IngredientPairCopyWithImpl<$Res, $Val extends IngredientPair>
    implements $IngredientPairCopyWith<$Res> {
  _$IngredientPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IngredientPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ingredient = null, Object? measure = null}) {
    return _then(
      _value.copyWith(
            ingredient: null == ingredient
                ? _value.ingredient
                : ingredient // ignore: cast_nullable_to_non_nullable
                      as String,
            measure: null == measure
                ? _value.measure
                : measure // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IngredientPairImplCopyWith<$Res>
    implements $IngredientPairCopyWith<$Res> {
  factory _$$IngredientPairImplCopyWith(
    _$IngredientPairImpl value,
    $Res Function(_$IngredientPairImpl) then,
  ) = __$$IngredientPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ingredient, String measure});
}

/// @nodoc
class __$$IngredientPairImplCopyWithImpl<$Res>
    extends _$IngredientPairCopyWithImpl<$Res, _$IngredientPairImpl>
    implements _$$IngredientPairImplCopyWith<$Res> {
  __$$IngredientPairImplCopyWithImpl(
    _$IngredientPairImpl _value,
    $Res Function(_$IngredientPairImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IngredientPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ingredient = null, Object? measure = null}) {
    return _then(
      _$IngredientPairImpl(
        ingredient: null == ingredient
            ? _value.ingredient
            : ingredient // ignore: cast_nullable_to_non_nullable
                  as String,
        measure: null == measure
            ? _value.measure
            : measure // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IngredientPairImpl implements _IngredientPair {
  const _$IngredientPairImpl({required this.ingredient, required this.measure});

  factory _$IngredientPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$IngredientPairImplFromJson(json);

  @override
  final String ingredient;
  @override
  final String measure;

  @override
  String toString() {
    return 'IngredientPair(ingredient: $ingredient, measure: $measure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientPairImpl &&
            (identical(other.ingredient, ingredient) ||
                other.ingredient == ingredient) &&
            (identical(other.measure, measure) || other.measure == measure));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ingredient, measure);

  /// Create a copy of IngredientPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IngredientPairImplCopyWith<_$IngredientPairImpl> get copyWith =>
      __$$IngredientPairImplCopyWithImpl<_$IngredientPairImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IngredientPairImplToJson(this);
  }
}

abstract class _IngredientPair implements IngredientPair {
  const factory _IngredientPair({
    required final String ingredient,
    required final String measure,
  }) = _$IngredientPairImpl;

  factory _IngredientPair.fromJson(Map<String, dynamic> json) =
      _$IngredientPairImpl.fromJson;

  @override
  String get ingredient;
  @override
  String get measure;

  /// Create a copy of IngredientPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IngredientPairImplCopyWith<_$IngredientPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
