import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_provider.freezed.dart';
part 'filter_provider.g.dart';

@freezed
class FilterState with _$FilterState {
  const factory FilterState({
    @Default('') String query,
    String? category,
    String? area,
    @Default(true) bool sortAscending,
  }) = _FilterState;
}

@riverpod
class FilterController extends _$FilterController {
  @override
  FilterState build() {
    return const FilterState();
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void setCategory(String? category) {
    state = state.copyWith(category: category);
  }

  void setArea(String? area) {
    state = state.copyWith(area: area);
  }

  void toggleSortOrder() {
    state = state.copyWith(sortAscending: !state.sortAscending);
  }

  void clearFilters() {
    state = const FilterState();
  }
}
