import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder/features/recipes/presentation/providers/filter_provider.dart';

void main() {
  group('FilterController', () {
    test('initial state should be empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(filterControllerProvider);

      expect(state.query, '');
      expect(state.category, null);
      expect(state.area, null);
      expect(state.sortAscending, true);
    });

    test('should update query', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(filterControllerProvider.notifier).setQuery('pizza');

      expect(container.read(filterControllerProvider).query, 'pizza');
    });

    test('should update category', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(filterControllerProvider.notifier).setCategory('Seafood');

      expect(container.read(filterControllerProvider).category, 'Seafood');
    });

    test('should toggle sort order', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(filterControllerProvider.notifier).toggleSortOrder();

      expect(container.read(filterControllerProvider).sortAscending, false);

      container.read(filterControllerProvider.notifier).toggleSortOrder();

      expect(container.read(filterControllerProvider).sortAscending, true);
    });

    test('should clear filters', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(filterControllerProvider.notifier);
      notifier.setQuery('pizza');
      notifier.setCategory('Seafood');
      notifier.toggleSortOrder();

      notifier.clearFilters();

      final state = container.read(filterControllerProvider);
      expect(
        state.query,
        '',
      ); // Implementation of clearFilters resets only query?
      // Checking implementation: `state = const FilterState();`
      // So it resets query to '' (default) and sortAscending to true (default).
      expect(state.category, null);
      expect(state.sortAscending, true);
    });
  });
}
