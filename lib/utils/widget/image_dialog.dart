import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imagePath;

  const ImageDialog({
    super.key,
    required this.imagePath,
  });

  static void show(
    BuildContext context, {
    required String imagePath,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => ImageDialog(imagePath: imagePath),
    );
  }

  bool get isNetwork =>
      imagePath.startsWith('http://') || imagePath.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            isNetwork
                ? CachedNetworkImage(
                    imageUrl: imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
