import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isPrimary;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
      label: Text(
        label,
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: isPrimary ? Colors.white : theme.colorScheme.onSurface,
        ),
      ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceVariant,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
      ),
    );
  }
}
