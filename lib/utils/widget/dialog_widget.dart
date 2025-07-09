import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../app/theme/dimens.dart';
import '../../utils/extension/context_ext.dart';
import '../../utils/widget/spacer_widget.dart';
import 'button_widget.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? buttonTitle;
  final Function()? onTap;

  const AppDialog({super.key, this.title, required this.message, this.buttonTitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    final myTheme = context.myTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimens.spacing40),
              child: Container(
                padding: const EdgeInsets.all(AppDimens.spacing15),
                decoration:
                    BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppDimens.buttonRadius)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (title != null) ...{
                      Text(
                        'title!',
                        style: myTheme.textThemeT1.bigTitle.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      )
                    },
                    const VSpacing(spacing: AppDimens.spacing20),
                    Text(
                      message,
                      style: myTheme.textThemeT1.error.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                      maxLines: 8,
                    ),
                    const VSpacing(spacing: AppDimens.spacing30),
                    AppPrimaryButton(
                      titleStyle: context.myTheme.textThemeT1.button.copyWith(color: Colors.white),
                      buttonColor: Colors.grey,
                      onPressed: onTap ?? () => context.router.maybePop(),
                      title: buttonTitle ?? "Close",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppOptionalDialog extends StatelessWidget {
  final String? title;
  final String message;
  final String? buttonTitle;
  final VoidCallback onPressedBtn;
  final String? altButtonTitle;
  final VoidCallback onPressedAltBtn;

  const AppOptionalDialog({
    super.key,
    this.title,
    required this.message,
    this.buttonTitle,
    this.altButtonTitle,
    required this.onPressedAltBtn,
    required this.onPressedBtn,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = context.myTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimens.spacing40),
          child: Container(
            padding: const EdgeInsets.all(AppDimens.spacing15),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppDimens.buttonRadius)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (title != null) ...{
                  Text(
                    'title!',
                    style: myTheme.textThemeT1.bigTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  )
                },
                const VSpacing(spacing: AppDimens.spacing20),
                Text(
                  message,
                  style: myTheme.textThemeT1.error,
                  textAlign: TextAlign.center,
                  maxLines: 8,
                ),
                const VSpacing(spacing: AppDimens.spacing20),
                const Divider(),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      AppTextButton(
                        style: context.myTheme.buttonThemeT1.button,
                        onPressed: () => onPressedBtn(),
                        title: buttonTitle ?? 'Đồng ý',
                      ),
                      AppTextButton(
                        style: context.myTheme.textThemeT1.button,
                        onPressed: () => onPressedAltBtn(),
                        title: altButtonTitle ?? 'Hủy',
                      )
                    ]),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
