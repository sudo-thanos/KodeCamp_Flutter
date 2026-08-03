import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_detail_controller.dart';
import '../controllers/cart_controller.dart';
import '../routes/app_routes.dart';

class RecipeDetailView extends StatelessWidget {
  const RecipeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecipeDetailController>();
    final cart = Get.find<CartController>();
    final recipe = controller.recipe;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Badge(
                  label: Obx(() => Text('${cart.totalItemCount}')),
                  isLabelVisible: cart.totalItemCount > 0,
                  child: const CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                onPressed: () => Get.toNamed(AppRoutes.cart),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'recipe-image-${recipe.id}',
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 48),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${recipe.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _MetaRow(recipe: recipe),
                  if (recipe.tags.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: recipe.tags
                          .map((tag) => _TagChip(label: tag))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _StatsGrid(recipe: recipe),
                  if (recipe.ingredients.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    const _SectionTitle(title: 'Ingredients'),
                    const SizedBox(height: 8),
                    ...recipe.ingredients.map(
                      (ingredient) => _BulletRow(text: ingredient),
                    ),
                  ],
                  if (recipe.instructions.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    const _SectionTitle(title: 'Instructions'),
                    const SizedBox(height: 8),
                    ...recipe.instructions.asMap().entries.map(
                      (entry) => _StepRow(
                        index: entry.key + 1,
                        text: entry.value,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              _QuantityStepper(controller: controller),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.addToCart,
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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

class _QuantityStepper extends StatelessWidget {
  final RecipeDetailController controller;
  const _QuantityStepper({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: controller.decrement,
          ),
          Obx(
            () => Text(
              '${controller.quantity.value}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.increment,
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final dynamic recipe;
  const _MetaRow({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
            const SizedBox(width: 2),
            Text(
              '${recipe.rating} (${recipe.reviewCount})',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        if (recipe.cuisine.isNotEmpty)
          Text(
            recipe.cuisine,
            style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
        if (recipe.difficulty.isNotEmpty) _DifficultyBadge(difficulty: recipe.difficulty),
      ],
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final String difficulty;
  const _DifficultyBadge({required this.difficulty});

  Color get _color {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        difficulty,
        style: TextStyle(color: _color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.teal),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final dynamic recipe;
  const _StatsGrid({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final stats = <_StatData>[
      _StatData(
        icon: Icons.timer_outlined,
        label: 'Time',
        value: recipe.totalTimeMinutes > 0 ? '${recipe.totalTimeMinutes} min' : '—',
      ),
      _StatData(
        icon: Icons.people_alt_outlined,
        label: 'Servings',
        value: '${recipe.servings}',
      ),
      _StatData(
        icon: Icons.local_fire_department_outlined,
        label: 'Calories',
        value: recipe.caloriesPerServing > 0 ? '${recipe.caloriesPerServing} kcal' : '—',
      ),
    ];

    final children = <Widget>[];
    for (var i = 0; i < stats.length; i++) {
      children.add(Expanded(child: _StatCard(data: stats[i])));
      if (i != stats.length - 1) children.add(const SizedBox(width: 12));
    }

    return Row(children: children);
  }
}

class _StatData {
  final IconData icon;
  final String label;
  final String value;
  _StatData({required this.icon, required this.label, required this.value});
}

class _StatCard extends StatelessWidget {
  final _StatData data;
  const _StatCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(data.icon, color: Colors.teal, size: 22),
          const SizedBox(height: 6),
          Text(data.value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          const SizedBox(height: 2),
          Text(data.label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
    );
  }
}

class _BulletRow extends StatelessWidget {
  final String text;
  const _BulletRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, size: 18, color: Colors.teal),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final int index;
  final String text;
  const _StepRow({required this.index, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
            child: Text(
              '$index',
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14, height: 1.4)),
          ),
        ],
      ),
    );
  }
}
