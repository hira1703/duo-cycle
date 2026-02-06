import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DayStrip extends StatelessWidget {
  const DayStrip({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onSelect,
  });

  final List<int> days;
  final int selectedDay;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final d = days[i];
          final isSelected = d == selectedDay;

          return GestureDetector(
            onTap: () => onSelect(d),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : AppColors.accent,
                borderRadius: BorderRadius.circular(23),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  )
                ]
                    : null,
              ),
              child: Text(
                "$d",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.black : Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
