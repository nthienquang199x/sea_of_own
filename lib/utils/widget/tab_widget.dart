import 'package:app_base/app/theme/colors.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  const TabWidget(
      {super.key, required this.label, this.isActive = false, this.onTap});
  final bool isActive;
  final String label;
  final Function()? onTap;
  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isActive ? AppColor.colorDF7838 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(widget.label,
            style: context.myTheme.textThemeT1.body.copyWith(
              color: widget.isActive ? Colors.white : AppColor.base30,
              fontSize: 14,
              fontWeight: widget.isActive ? FontWeight.bold : FontWeight.normal,
            )),
      ),
    );
  }
}
