import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

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
        _LottieLoader(
          size: dimension ?? AppDimens.icon80,
          color: color ?? context.myTheme.colorScheme.cardColor,
        )
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
          const SizedBox.square(
            dimension: AppDimens.icon80,
            child: _LottieLoader(
              size: AppDimens.icon80,
              color: Colors.red,
            ),
          ),
          // Stack(
          //   alignment: AlignmentDirectional.center,
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           height: AppDimens.spacing60,
          //           width: AppDimens.spacing80,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius:
          //                   BorderRadius.circular(AppDimens.buttonRadius)),
          //         ),
          //       ],
          //     ),
          //     const Column(
          //       children: [
          //         SizedBox.square(
          //           dimension: AppDimens.icon60,
          //           child: _LottieLoader(
          //             size: AppDimens.icon60,
          //             color: Colors.grey,
          //           ),
          //         )
          //       ],
          //     ),
          //   ],
          // ),
          if (message != null) ...{
            const VSpacing(
              spacing: AppDimens.spacing20,
            ),
            Text(
              message!,
              style: context.myTheme.textThemeT1.light.copyWith(
                  color: context.myTheme.colorScheme.textBtnColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
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
    AppLoadingControllerParams(
        visible: false, hasBlurBackground: true, message: null),
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
  const AppLoadingHUD(
      {super.key, required this.child, required this.controller});

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
                    backgroundColor: Colors.transparent,
                  ));
            })
      ],
    );
  }
}

class _LottieLoader extends StatelessWidget {
  const _LottieLoader({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ByteData>(
      future: rootBundle.load('assets/lotties/loading.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Lottie.memory(
            snapshot.data!.buffer.asUint8List(),
            repeat: true,
            width: size,
            height: size,
            fit: BoxFit.contain,
          );
        }
        return LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          colors: [color],
          strokeWidth: 1.5,
        );
      },
    );
  }
}
