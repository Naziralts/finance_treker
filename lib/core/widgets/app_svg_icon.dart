import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIcon extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;
  final bool animated;

  const AppSvgIcon({
    super.key,
    required this.path,
    this.size = 24,
    this.color,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? Theme.of(context).iconTheme.color!,
        BlendMode.srcIn,
      ),
    );

    if (!animated) return icon;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: icon,
    );
  }
}
