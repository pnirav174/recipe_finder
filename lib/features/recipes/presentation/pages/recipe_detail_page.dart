import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import '../../data/models/recipe_model.dart';

import '../providers/recipe_detail_provider.dart';
import 'package:recipe_finder/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:recipe_finder/features/favorites/data/providers.dart';

class RecipeDetailPage extends ConsumerWidget {
  final String recipeId;
  final RecipeModel? initialRecipe;

  const RecipeDetailPage({
    super.key,
    required this.recipeId,
    this.initialRecipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeDetailProvider(recipeId));

    return Scaffold(
      body: recipeAsync.when(
        data: (recipe) {
          if (recipe == null) {
            return const Center(child: Text('Recipe not found'));
          }
          return _RecipeDetailView(recipe: recipe);
        },
        loading: () {
          if (initialRecipe != null) {
            // Show initial data with skeleton placeholders for missing details
            return _RecipeDetailView(recipe: initialRecipe!, isPartial: true);
          }
          // Full page skeleton
          return const _RecipeDetailSkeleton();
        },
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _RecipeDetailSkeleton extends StatelessWidget {
  const _RecipeDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(color: Colors.white),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 24, width: 200, color: Colors.white),
              const SizedBox(height: 16),
              Container(height: 16, width: 150, color: Colors.white),
              const SizedBox(height: 8),
              Container(height: 16, width: 100, color: Colors.white),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(height: 60, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeDetailView extends ConsumerStatefulWidget {
  final RecipeModel recipe;
  final bool isPartial;

  const _RecipeDetailView({required this.recipe, this.isPartial = false});

  @override
  ConsumerState<_RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends ConsumerState<_RecipeDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(isFavoriteProvider(widget.recipe.id));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new),
                        color: Colors.white,
                        iconSize: 18,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),
              ),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final settings = context
                      .dependOnInheritedWidgetOfExactType<
                        FlexibleSpaceBarSettings
                      >();

                  final isCollapsed = settings == null
                      ? false
                      : settings.currentExtent <= settings.minExtent + 20;
                  final isDark =
                      Theme.of(context).brightness == Brightness.dark;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: isCollapsed
                        ? Text(
                            widget.recipe.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                color: Colors.black.withOpacity(0.3),
                                child: Text(
                                  widget.recipe.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    background: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                _ImageViewer(imageUrl: widget.recipe.thumbUrl),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'recipe_image_${widget.recipe.id}',
                        child: CachedNetworkImage(
                          imageUrl: widget.recipe.thumbUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.white,
                            child: Container(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Ingredients'),
                    Tab(text: 'Instructions'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverview(context),
            _buildIngredients(context),
            _buildInstructions(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref
              .read(favoritesRepositoryProvider)
              .toggleFavorite(widget.recipe);
        },
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }

  Widget _buildOverview(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            Icons.category,
            'Category',
            widget.recipe.category ?? 'Unknown',
          ),
          _buildInfoRow(
            Icons.public,
            'Cuisine',
            widget.recipe.area ?? 'Unknown',
          ),
          if (widget.recipe.youtubeUrl != null &&
              widget.recipe.youtubeUrl!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Launch video
                  _launchUrl(widget.recipe.youtubeUrl!);
                },
                icon: const Icon(Icons.play_circle),
                label: const Text("Watch Video"),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildIngredients(BuildContext context) {
    if (widget.isPartial) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(height: 60, color: Colors.white),
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.recipe.ingredients.length,
      itemBuilder: (context, index) {
        final item = widget.recipe.ingredients[index];
        return Card(
          child: ListTile(
            title: Text(item.ingredient),
            trailing: Text(
              item.measure,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructions(BuildContext context) {
    if (widget.isPartial) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(height: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Text(
        widget.recipe.instructions ?? 'No instructions available.',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

class _ImageViewer extends StatelessWidget {
  final String imageUrl;
  const _ImageViewer({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.white,
                  iconSize: 18,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: PhotoView(imageProvider: CachedNetworkImageProvider(imageUrl)),
    );
  }
}

// Helper provider for favorites check using the stream
final isFavoriteProvider = Provider.family.autoDispose<bool, String>((ref, id) {
  final favorites = ref.watch(favoritesProvider).valueOrNull ?? [];
  return favorites.any((e) => e.id == id);
});

// End of file
