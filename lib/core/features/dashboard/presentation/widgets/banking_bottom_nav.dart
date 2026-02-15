import 'package:finance_treker/core/constants/app_colors.dart';
import 'package:finance_treker/core/constants/app_icons.dart';
import 'package:finance_treker/core/widgets/app_svg_icon.dart' show AppSvgIcon;
import 'package:flutter/material.dart';


class BankingBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BankingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _item(0, AppIcons.home),
          _item(1, AppIcons.stats),
          _item(2, AppIcons.add),
          _item(3, AppIcons.settings),
        ],
      ),
    );
  }

  Widget _item(int index, String iconPath) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isActive
              ? const LinearGradient(
                  colors: [
                    AppColors.primaryStart,
                    AppColors.primaryEnd,
                  ],
                )
              : null,
        ),
        child: AppSvgIcon(
          path: iconPath,
          size: 22,
          color: isActive
              ? Colors.white
              : Colors.grey.shade400,
        ),
      ),
    );
  }
}
