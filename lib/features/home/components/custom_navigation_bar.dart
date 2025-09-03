import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/navigation_type.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key, required this.type, this.onTap});
  final NavigationType type;
  final Function(NavigationType type)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          // bottom: math.max(0, MediaQuery.of(context).padding.bottom - 4),
          bottom: 12),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.tab,
        border: Border(
          top: BorderSide(
            color: context.myTheme.colorScheme.separator1,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: NavigationType.values.map((e) {
          final isSelected = type == e;

          return GestureDetector(
            onTap: onTap != null ? () => onTap!(e) : null,
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  e.icon,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? context.myTheme.colorScheme.iconActive
                        : context.myTheme.colorScheme.iconInactive,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
