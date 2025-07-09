import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../app/theme/dimens.dart';
import '../../utils/widget/spacer_widget.dart';
import '../extension/context_ext.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.color, this.dimension});

  final Color? color;
  final double? dimension;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: dimension ?? AppDimens.icon25,
          child: LoadingIndicator(
            indicatorType: Indicator.circleStrokeSpin,
            colors: [
              color ?? context.myTheme.colorScheme.cardColor,
            ],
            strokeWidth: 1,
          ),
        ),
      ],
    );
  }
}

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key, this.message, this.backgroundColor});

  final String? message;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor ?? Colors.grey.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: AppDimens.spacing60,
                    width: AppDimens.spacing80,
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppDimens.buttonRadius)),
                  ),
                ],
              ),
              const Column(
                children: [
                  SizedBox.square(
                    dimension: AppDimens.icon30,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,
                      colors: [
                        Colors.grey,
                      ],
                      strokeWidth: 2,
                    ),
                  )
                ],
              ),
            ],
          ),
          if (message != null) ...{
            const VSpacing(
              spacing: AppDimens.spacing20,
            ),
            Text(
              message!,
              style: context.myTheme.textThemeT1.light
                  .copyWith(color: context.myTheme.colorScheme.textBtnColor, fontWeight: FontWeight.w700, fontSize: 18),
              textAlign: TextAlign.center,
            )
          },
        ],
      ),
    );
  }
}

class AppLoadingController {
  final params = ValueNotifier<AppLoadingControllerParams>(
    AppLoadingControllerParams(visible: false, hasBlurBackground: true, message: null),
  );

  showLoading({bool blurBG = true, String? msg}) {
    params.value = params.value.copyWith(
      visible: true,
      hasBlurBackground: blurBG,
      message: msg,
    );
  }

  hideLoading() {
    params.value = params.value.copyWith(visible: false);
  }
}

class AppLoadingControllerParams {
  final bool visible;
  final bool hasBlurBackground;
  final String? message;

  AppLoadingControllerParams({
    required this.visible,
    required this.hasBlurBackground,
    required this.message,
  });

  AppLoadingControllerParams copyWith({
    bool? visible,
    bool? hasBlurBackground,
    String? message,
  }) {
    return AppLoadingControllerParams(
      visible: visible ?? this.visible,
      hasBlurBackground: hasBlurBackground ?? this.hasBlurBackground,
      message: message ?? this.message,
    );
  }
}

class AppLoadingHUD extends StatelessWidget {
  const AppLoadingHUD({super.key, required this.child, required this.controller});

  final Widget child;
  final AppLoadingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ValueListenableBuilder<AppLoadingControllerParams>(
            valueListenable: controller.params,
            builder: (context, visible, child) {
              return Visibility(
                  visible: controller.params.value.visible,
                  child: AppLoadingWidget(
                    message: controller.params.value.message,
                  ));
            })
      ],
    );
  }
}
