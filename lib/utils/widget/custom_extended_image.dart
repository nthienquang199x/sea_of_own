import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

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
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return customLoadingWidget ??
                Center(
                  child: CircularProgressIndicator(
                    color: loadingColor,
                    strokeWidth: 2,
                  ),
                );
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return customErrorWidget ??
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: errorColor,
                        size: errorIconSize,
                      ),
                      if (errorText != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          errorText!,
                          style: TextStyle(
                            color: errorColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                );
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
          mode: ExtendedImageMode.gesture,
          inPageView: false,
          maxScale: 3.0,
          animationMaxScale: 3.5,
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
  }) : super(
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          inPageView: true,
          loadingColor: Colors.white,
          errorColor: Colors.red,
          errorText: 'Failed to load image',
        );
}
