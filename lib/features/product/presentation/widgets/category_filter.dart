import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  final GlobalKey _categoryKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _showCategoryDropdown() {
    // Get the context from the key
    final BuildContext? widgetContext = _categoryKey.currentContext;
    if (widgetContext == null) return;

    // Find the render object
    final RenderObject? renderObject = widgetContext.findRenderObject();
    if (renderObject == null) return;

    // Cast to RenderBox
    if (renderObject is! RenderBox) return;

    // Now safely calculate the offset
    final RenderBox renderBox = renderObject;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    // Create and show the overlay
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + renderBox.size.height,
        width: renderBox.size.width,
        child: Material(
          elevation: 4,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // "All" option
                ListTile(
                  title: const Text('All Categories'),
                  onTap: () {
                    widget.onCategorySelected(null);
                    _hideCategoryDropdown();
                  },
                ),
                // Category options
                ...widget.categories.map((category) {
                  return ListTile(
                    title: Text(category),
                    onTap: () {
                      widget.onCategorySelected(category);
                      _hideCategoryDropdown();
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay
    Overlay.of(widgetContext).insert(_overlayEntry!);
  }

  void _hideCategoryDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _categoryKey,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: _showCategoryDropdown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedCategory ?? 'All Categories',
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideCategoryDropdown();
    super.dispose();
  }
}
