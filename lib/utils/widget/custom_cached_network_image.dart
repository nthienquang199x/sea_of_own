import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../app/theme/colors.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double loadingSize;
  final Color? errorColor;
  final Widget? errorWidget;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.loadingSize = 50,
    this.errorColor,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Center(
        child: FutureBuilder<ByteData>(
          future: rootBundle.load('assets/lotties/loading.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return SizedBox(
                width: loadingSize,
                height: loadingSize,
                child: Lottie.memory(
                  snapshot.data!.buffer.asUint8List(),
                  repeat: true,
                  width: loadingSize,
                  height: loadingSize,
                  fit: BoxFit.fill,
                ),
              );
            }
            return SizedBox(
              width: loadingSize,
              height: loadingSize,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            decoration: BoxDecoration(
              color: errorColor ?? AppColor.colorDADADA,
            ),
          ),
    );
  }
}
