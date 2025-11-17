import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.gold : Colors.white24,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.gold, width: selected ? 0 : 1),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.black : AppTheme.gold,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
