import 'package:flutter/material.dart';

// Reusable widget components
class AppWidgets {
  // Status badge widget
  static Widget statusBadge({
    required String status,
    required BuildContext context,
    double? fontSize,
    Color? customColor,
    String? customText,
  }) {
    Color backgroundColor;
    Color textColor;
    String displayStatus = customText ?? status.toUpperCase();

    if (customColor != null) {
      backgroundColor = customColor.withOpacity(0.15);
      textColor = customColor;
    } else {
      switch (status.toLowerCase()) {
        case 'pending':
          backgroundColor = Colors.orange.withOpacity(0.15);
          textColor = Colors.orange;
          break;
        case 'confirmed':
          backgroundColor = Colors.blue.withOpacity(0.15);
          textColor = Colors.blue;
          break;
        case 'preparing':
          backgroundColor = Colors.deepOrange.withOpacity(0.15);
          textColor = Colors.deepOrange;
          break;
        case 'ready':
        case 'completed':
          backgroundColor = Colors.green.withOpacity(0.15);
          textColor = Colors.green;
          break;
        case 'cancelled':
          backgroundColor = Colors.red.withOpacity(0.15);
          textColor = Colors.red;
          break;
        default:
          backgroundColor = Colors.grey.withOpacity(0.15);
          textColor = Colors.grey;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: textColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        displayStatus,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: fontSize ?? 12,
            ),
      ),
    );
  }

  // Card decoration
  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardTheme.color,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  // Elevated card decoration
  static BoxDecoration elevatedCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardTheme.color,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 6,
          offset: Offset(0, 1),
        ),
      ],
      border: Border.all(
        color: Theme.of(context).dividerTheme.color!.withOpacity(0.3),
        width: 1,
      ),
    );
  }

  // Loading indicator
  static Widget loadingIndicator({
    double size = 40,
    Color? color,
    BuildContext? context,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ??
              (context != null ? Theme.of(context).primaryColor : Colors.blue),
        ),
      ),
    );
  }

  // Section header
  static Widget sectionHeader({
    required BuildContext context,
    required String title,
    String? actionText,
    VoidCallback? onAction,
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!,
          ),
          if (actionText != null && onAction != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                actionText,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            )
          else if (trailing != null)
            trailing,
        ],
      ),
    );
  }

  // Empty state
  static Widget emptyState({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? description,
    Widget? action,
    double iconSize = 64,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: Theme.of(context).disabledColor,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).disabledColor.withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action,
            ],
          ],
        ),
      ),
    );
  }

  // Price display
  static Widget priceDisplay({
    required BuildContext context,
    required double price,
    TextStyle? style,
    bool withCurrency = true,
    String currencySymbol = '\$',
  }) {
    return Text(
      '${withCurrency ? currencySymbol : ''}${price.toStringAsFixed(2)}',
      style: style ??
          Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
    );
  }

  // Info chip
  static Widget infoChip({
    required BuildContext context,
    required IconData icon,
    required String text,
    Color? backgroundColor,
    Color? iconColor,
    Color? textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: iconColor ?? Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: textColor ?? Theme.of(context).primaryColor,
                ),
          ),
        ],
      ),
    );
  }

  // Quantity selector
  static Widget quantitySelector({
    required BuildContext context,
    required int quantity,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
    bool isCompact = false,
    Color? selectorColor,
  }) {
    final color = selectorColor ?? Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 20),
            onPressed: onDecrease,
            color: color,
            padding: isCompact
                ? const EdgeInsets.all(8)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: const BoxConstraints(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              quantity.toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 20),
            onPressed: onIncrease,
            color: color,
            padding: isCompact
                ? const EdgeInsets.all(8)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// Quick theme access extension
extension WidgetsExtension on BuildContext {
  Widget statusBadge(String status,
          {double? fontSize, Color? color, String? text}) =>
      AppWidgets.statusBadge(
        status: status,
        context: this,
        fontSize: fontSize,
        customColor: color,
        customText: text,
      );

  Widget loadingIndicator({double size = 40, Color? color}) =>
      AppWidgets.loadingIndicator(
        size: size,
        color: color,
        context: this,
      );

  Widget emptyState({
    required IconData icon,
    required String title,
    String? description,
    Widget? action,
    double iconSize = 64,
  }) =>
      AppWidgets.emptyState(
        context: this,
        icon: icon,
        title: title,
        description: description,
        action: action,
        iconSize: iconSize,
      );

  Widget sectionHeader({
    required String title,
    String? actionText,
    VoidCallback? onAction,
    Widget? trailing,
  }) =>
      AppWidgets.sectionHeader(
        context: this,
        title: title,
        actionText: actionText,
        onAction: onAction,
        trailing: trailing,
      );

  Widget infoChip({
    required IconData icon,
    required String text,
    Color? backgroundColor,
    Color? iconColor,
    Color? textColor,
  }) =>
      AppWidgets.infoChip(
        context: this,
        icon: icon,
        text: text,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        textColor: textColor,
      );

  Widget priceDisplay({
    required double price,
    TextStyle? style,
    bool withCurrency = true,
    String currencySymbol = '\$',
  }) =>
      AppWidgets.priceDisplay(
        context: this,
        price: price,
        style: style,
        withCurrency: withCurrency,
        currencySymbol: currencySymbol,
      );

  Widget quantitySelector({
    required int quantity,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
    bool isCompact = false,
    Color? selectorColor,
  }) =>
      AppWidgets.quantitySelector(
        context: this,
        quantity: quantity,
        onDecrease: onDecrease,
        onIncrease: onIncrease,
        isCompact: isCompact,
        selectorColor: selectorColor,
      );
}
