import 'package:app_base/app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';
import '../../utils/extension/context_ext.dart';

class AppPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? buttonColor;
  final TextStyle? titleStyle;
  final double? buttonHeight;
  final bool enable;

  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.buttonColor,
    this.buttonHeight,
    this.enable = true,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? AppDimens.buttonHeight,
      child: Opacity(
          opacity: enable ? 1 : 0.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    buttonColor ?? context.myTheme.colorScheme.primary),
            onPressed: enable ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(title,
                  style:
                      titleStyle ?? context.myTheme.buttonTitleThemeT1.button),
            ),
          )),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color? titleColor;
  final TextStyle? style;
  final bool enable;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.titleColor,
    this.style,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enable ? onPressed : null,
      child: Text(
        title,
        style: style ??
            context.myTheme.buttonThemeT1.textButton.copyWith(
              color: titleColor ?? context.myTheme.colorScheme.primary,
            ),
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final bool hasDropShadown;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? shadownColor;
  final double? height;
  final double? width;

  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.hasDropShadown = false,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.shadownColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimens.buttonRadius,
          ),
          boxShadow: hasDropShadown
              ? [
                  BoxShadow(
                    color: shadownColor ?? Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 4,
                  )
                ]
              : null),
      child: SizedBox(
        height: height,
        width: width,
        child: CupertinoButton(
          onPressed: onPressed,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: icon,
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isFilled;
  final double fontSize;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;

  const RoundedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.padding = const EdgeInsets.all(16.0),
    this.isFilled = true,
    this.width,
    this.fontSize = 16.0,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.myTheme.textThemeT1.title;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isFilled ? AppColor.colorDF7838 : Colors.transparent,
          borderRadius: BorderRadius.circular(100.0),
          border: isFilled ? null : Border.all(color: AppColor.base80),
        ),
        child: Text(
          title,
          style: theme.copyWith(
              fontSize: fontSize,
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
