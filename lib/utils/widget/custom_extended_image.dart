import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

class CustomExtendedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final ExtendedImageMode mode;
  final bool cache;
  final bool inPageView;
  final double minScale;
  final double maxScale;
  final double animationMinScale;
  final double animationMaxScale;
  final double initialScale;
  final double speed;
  final double inertialSpeed;
  final InitialAlignment initialAlignment;
  final Color loadingColor;
  final Color errorColor;
  final double errorIconSize;
  final String? errorText;
  final Widget? customLoadingWidget;
  final Widget? customErrorWidget;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  const CustomExtendedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.mode = ExtendedImageMode.gesture,
    this.cache = true,
    this.inPageView = true,
    this.minScale = 0.9,
    this.maxScale = 4.0,
    this.animationMinScale = 0.7,
    this.animationMaxScale = 4.5,
    this.initialScale = 1.0,
    this.speed = 1.0,
    this.inertialSpeed = 100.0,
    this.initialAlignment = InitialAlignment.center,
    this.loadingColor = Colors.white,
    this.errorColor = Colors.red,
    this.errorIconSize = 50,
    this.errorText,
    this.customLoadingWidget,
    this.customErrorWidget,
    this.onTap,
    this.onDoubleTap,
    this.borderRadius,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = ExtendedImage.network(
      imageUrl,
      fit: fit,
      mode: mode,
      cache: cache,
      width: width,
      height: height,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: minScale,
          animationMinScale: animationMinScale,
          maxScale: maxScale,
          animationMaxScale: animationMaxScale,
          speed: speed,
          inertialSpeed: inertialSpeed,
          initialScale: initialScale,
          inPageView: inPageView,
          initialAlignment: initialAlignment,
        );
      },
      onDoubleTap: onDoubleTap != null
          ? (ExtendedImageGestureState state) {
              final currentScale = state.gestureDetails?.totalScale ?? 1.0;
              double targetScale;

              if (currentScale <= 1.0) {
                targetScale = 3.0;
              } else {
                targetScale = 1.0;
              }

              state.handleDoubleTap(
                scale: targetScale,
                doubleTapPosition: state.pointerDownPosition,
              );
            }
          : null,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return customLoadingWidget ??
                Center(
                  child: FutureBuilder<ByteData>(
                    future: rootBundle.load('assets/lotties/loading.json'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Lottie.memory(
                          snapshot.data!.buffer.asUint8List(),
                          repeat: true,
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        );
                      }
                      return const LoadingIndicator(
                        indicatorType: Indicator.circleStrokeSpin,
                        colors: [Colors.black],
                        strokeWidth: 1.5,
                      );
                    },
                  ),
                );
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return const SizedBox();
        }
      },
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }
    if (onTap != null) {
      image = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: image,
      );
    }

    return image;
  }
}

class ProductExtendedImage extends CustomExtendedImage {
  const ProductExtendedImage({
    super.key,
    required super.imageUrl,
    super.onTap,
    super.borderRadius,
    super.width,
    super.height,
  }) : super(
          fit: BoxFit.cover,
          mode: ExtendedImageMode.none,
          loadingColor: Colors.grey,
          errorColor: Colors.grey,
          errorIconSize: 40,
        );
}

class GalleryExtendedImage extends CustomExtendedImage {
  const GalleryExtendedImage({
    super.key,
    required super.imageUrl,
    super.onTap,
    super.onDoubleTap,
  }) : super(
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          inPageView: false,
          minScale: 0.5,
          maxScale: 5.0,
          animationMinScale: 0.5,
          animationMaxScale: 5.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          loadingColor: Colors.white,
          errorColor: Colors.red,
          errorText: 'Failed to load image',
        );
}
