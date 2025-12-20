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
          backgroundColor = Colors.green.withOpacity(0.15);
          textColor = Colors.green;
          break;
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
          color: Color(0x14000000), // black with 0.08 opacity
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
          color: Color(0x0D000000), // black with 0.05 opacity
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
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
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

  // Custom divider
  static Widget customDivider({
    BuildContext? context,
    Color? color,
    double? thickness,
    double? height,
    EdgeInsets? padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Divider(
        height: height,
        thickness: thickness ?? 1,
        color: color ??
            (context != null
                ? Theme.of(context).dividerTheme.color
                : const Color(0xFFE0E0E0)), // Colors.grey[300]
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
        color: backgroundColor ?? const Color(0xFFE3F2FD), // Colors.blue[50]
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: iconColor ?? const Color(0xFF1976D2), // Colors.blue[700]
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color:
                      textColor ?? const Color(0xFF1976D2), // Colors.blue[700]
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  // Labeled value
  static Widget labeledValue({
    required BuildContext context,
    required String label,
    required String value,
    bool isBoldValue = true,
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color!
                    .withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: isBoldValue
              ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  )
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  // Shimmer loading placeholder
  static Widget shimmerPlaceholder({
    required double width,
    required double height,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Colors.grey[200]
        borderRadius:
            borderRadius ?? const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

// Quick theme access extension
extension WidgetsExtension on BuildContext {
  // Common widget helpers
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
}

// Animation constants
class AppAnimations {
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration buttonPress = Duration(milliseconds: 150);
  static const Duration snackbar = Duration(seconds: 3);
  static const Duration shimmer = Duration(milliseconds: 1500);
}

// Spacing constants
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);

  static EdgeInsets paddingHorizontal(double value) =>
      EdgeInsets.symmetric(horizontal: value);
  static EdgeInsets paddingVertical(double value) =>
      EdgeInsets.symmetric(vertical: value);
  static EdgeInsets paddingSym({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      );
}

// Border radius constants
class AppBorderRadius {
  static const BorderRadius xs = BorderRadius.all(Radius.circular(4));
  static const BorderRadius sm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius xl = BorderRadius.all(Radius.circular(24));
  static const BorderRadius round = BorderRadius.all(Radius.circular(999));

  static BorderRadius circular(double radius) =>
      BorderRadius.all(Radius.circular(radius));
}
