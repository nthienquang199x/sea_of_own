import 'package:app_base/app/theme/icons.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/features/profile/components/custom_button.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    this.title,
    this.titleButton,
    this.textColor,
    this.onTap,
    required this.child,
    this.showCloseButton = true,
    this.isDismissible = true,
  });

  final String? title;
  final String? titleButton;
  final Color? textColor;
  final void Function()? onTap;
  final Widget child;
  final bool showCloseButton;
  final bool isDismissible;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDismissible ? () => Navigator.of(context).pop() : null,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.muted,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.title != null) ...{
                        Text(
                          widget.title!.tr(context),
                          style: context.myTheme.textThemeT1.title.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: context.myTheme.colorScheme.foreground,
                          ),
                        ),
                        const SizedBox(height: 24),
                      },
                      widget.child,
                      if (widget.titleButton != null) ...{
                        const SizedBox(height: 24),
                        CustomButton(
                          title: widget.titleButton!,
                          onTap: widget.onTap ??
                              () {
                                Navigator.of(context).pop();
                              },
                          textColor: widget.textColor ??
                              context.myTheme.colorScheme.primaryForeground,
                        ),
                      },
                    ],
                  ),
                );
              },
            ),
          ),
          if (widget.showCloseButton)
            Positioned(
              top: -35,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child:
                    SvgPicture.asset(AppIcons.ic_close, width: 24, height: 24),
              ),
            ),
        ],
      ),
    );
  }
}
