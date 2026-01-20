import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/providers.dart';
import '../providers/recipe_list_provider.dart';
import '../providers/filter_provider.dart';
import '../widgets/recipe_card.dart';

class RecipeListPage extends ConsumerStatefulWidget {
  const RecipeListPage({super.key});

  @override
  ConsumerState<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends ConsumerState<RecipeListPage> {
  bool _isGrid = true;
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(filterControllerProvider.notifier).setQuery(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(recipeListProvider);
    final filter = ref.watch(filterControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            filter.sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
          ),
          tooltip: filter.sortAscending ? "Sort A-Z" : "Sort Z-A",
          onPressed: () {
            ref.read(filterControllerProvider.notifier).toggleSortOrder();
          },
        ),
        title: const Text('Recipe Finder'),
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGrid = !_isGrid;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              context.go('/favorites');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          // Filter Chips
          if (filter.category != null || filter.area != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  if (filter.category != null)
                    Chip(
                      label: Text(filter.category!),
                      onDeleted: () => ref
                          .read(filterControllerProvider.notifier)
                          .setCategory(null),
                    ),
                  if (filter.category != null && filter.area != null)
                    SizedBox(width: 8),
                  if (filter.area != null)
                    Chip(
                      label: Text(filter.area!),
                      onDeleted: () => ref
                          .read(filterControllerProvider.notifier)
                          .setArea(null),
                    ),
                ],
              ),
            ),

          // Recipe List
          Expanded(
            child: recipesAsync.when(
              data: (recipes) {
                if (recipes.isEmpty) {
                  return const Center(child: Text('No recipes found'));
                }
                return _isGrid
                    ? GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: recipes.length,
                        itemBuilder: (context, index) =>
                            RecipeCard(recipe: recipes[index]),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: recipes.length,
                        itemBuilder: (context, index) => SizedBox(
                          height: 250,
                          child: RecipeCard(recipe: recipes[index]),
                        ),
                      );
              },
              loading: () => _buildShimmerLoading(),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFilterDialog(context);
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Consumer(
              builder: (context, ref, child) {
                final categoriesAsync = ref.watch(categoriesProvider);
                final areasAsync = ref.watch(areasProvider);
                final filter = ref.watch(filterControllerProvider);

                return ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      'Filter Recipes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle(context, 'Category'),
                    const SizedBox(height: 8),
                    categoriesAsync.when(
                      data: (categories) => Wrap(
                        spacing: 8,
                        children: categories.map((c) {
                          final isSelected = filter.category == c.name;
                          return FilterChip(
                            label: Text(c.name),
                            selected: isSelected,
                            onSelected: (selected) {
                              ref
                                  .read(filterControllerProvider.notifier)
                                  .setCategory(selected ? c.name : null);
                            },
                          );
                        }).toList(),
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (e, s) => Text('Error: $e'),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle(context, 'Cuisine Area'),
                    const SizedBox(height: 8),
                    areasAsync.when(
                      data: (areas) => Wrap(
                        spacing: 8,
                        children: areas.map((a) {
                          final isSelected = filter.area == a.name;
                          return FilterChip(
                            label: Text(a.name),
                            selected: isSelected,
                            onSelected: (selected) {
                              ref
                                  .read(filterControllerProvider.notifier)
                                  .setArea(selected ? a.name : null);
                            },
                          );
                        }).toList(),
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (e, s) => Text('Error: $e'),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(filterControllerProvider.notifier)
                            .clearFilters();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Clear Filters'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildShimmerLoading() {
    return _isGrid
        ? GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 6,
            itemBuilder: (_, __) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(color: Colors.white, height: 200),
            ),
          )
        : ListView.builder(
            itemCount: 6,
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(color: Colors.white, height: 200),
              ),
            ),
          );
  }
}
