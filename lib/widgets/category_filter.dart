
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/field_provider.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FieldProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categories.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final category = provider.categories[index];

              final isSelected =
                  category == provider.selectedCategory;

              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) {
                  provider.setCategory(category);
                },
                selectedColor: const Color(0xFF42D878),
                backgroundColor: const Color(0xFF1C2832),
                side: BorderSide.none,
                labelStyle: TextStyle(
                  color: isSelected
                      ? const Color(0xFF0B1220)
                      : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
