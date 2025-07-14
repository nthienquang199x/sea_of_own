import 'package:app_base/utils/widget/custom_extended_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ExtendedImageGalleryViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ExtendedImageGalleryViewer({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<ExtendedImageGalleryViewer> createState() =>
      _ExtendedImageGalleryViewerState();

  static void showAsDialog(
    BuildContext context, {
    required List<String> images,
    int initialIndex = 0,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: ExtendedImageGalleryViewer(
          images: images,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

class _ExtendedImageGalleryViewerState
    extends State<ExtendedImageGalleryViewer> {
  late ExtendedPageController _pageController;
  late int currentIndex;
  final bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    final initialPage = widget.initialIndex + (widget.images.length * 500);
    _pageController = ExtendedPageController(initialPage: initialPage);
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDialog,
              behavior: HitTestBehavior.opaque,
              child: ExtendedImageGesturePageView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final imageIndex = index % widget.images.length;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GalleryExtendedImage(
                      imageUrl: widget.images[imageIndex],
                      onTap: _closeDialog,
                    ),
                  );
                },
                itemCount: widget.images.length * 1000,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index % widget.images.length;
                  });
                },
                controller: _pageController,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          if (_showOverlay)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 28),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Expanded(
                        child: Text(
                          '${currentIndex + 1} / ${widget.images.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48),
                      // IconButton(
                      //   icon: const Icon(Icons.share,
                      //       color: Colors.white, size: 28),
                      //   onPressed: () {
                      //     // Share functionality
                      //     print(
                      //         'Share image: ${widget.images[currentIndex]}');
                      //   },
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.download,
                      //       color: Colors.white, size: 28),
                      //   onPressed: () {
                      //     // Download functionality
                      //     print(
                      //         'Download image: ${widget.images[currentIndex]}');
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
