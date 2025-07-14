import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/features/profile/components/custom_button.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.titleButton,
      this.textColor,
      this.onTap,
      required this.child});
  final String title;
  final String titleButton;
  final Color? textColor;
  final void Function()? onTap;
  final Widget child;
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title.tr(context),
                style: context.myTheme.textThemeT1.title.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: context.myTheme.colorScheme.foreground,
                ),
              ),
              const SizedBox(height: 24),
              widget.child,
              const SizedBox(height: 24),
              CustomButton(
                  title: widget.titleButton,
                  onTap: widget.onTap ??
                      () {
                        Navigator.of(context).pop();
                      },
                  textColor: widget.textColor ??
                      context.myTheme.colorScheme.primaryForeground),
            ],
          ),
        ),
        Positioned(
          top: -40,
          right: 0,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
