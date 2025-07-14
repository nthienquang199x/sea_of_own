import 'package:app_base/models/product.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/custom_extended_image.dart';
import 'package:app_base/utils/widget/extended_image_gallery_viewer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product get product => widget.product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: context.myTheme.colorScheme.background,
            borderRadius: BorderRadius.circular(4),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildMainProductImage(),
                // ClipRRect(
                //   child: AspectRatio(
                //     aspectRatio: 1,
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: context.myTheme.colorScheme.primary,
                //         image: product.images.isNotEmpty
                //             ? DecorationImage(
                //                 image: NetworkImage(product.images.first),
                //                 fit: BoxFit.cover,
                //               )
                //             : null,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(product.category,
                                style:
                                    context.myTheme.textThemeT1.title.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: context.myTheme.colorScheme.foreground,
                                )),
                          ),
                          SvgPicture.asset(
                            "assets/icons/ic_product_share.svg",
                            colorFilter: ColorFilter.mode(
                              context.myTheme.colorScheme.foreground,
                              BlendMode.srcIn,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        style: context.myTheme.textThemeT1.title.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: context.myTheme.colorScheme.foreground),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${product.currency} ${product.price.toStringAsFixed(2)}',
                        style: context.myTheme.textThemeT1.title.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: context.myTheme.colorScheme.foreground),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/ic_product_heart.svg",
                              colorFilter: ColorFilter.mode(
                                context.myTheme.colorScheme.foreground,
                                BlendMode.srcIn,
                              )),
                          const SizedBox(width: 8),
                          Text('124',
                              style: context.myTheme.textThemeT1.title.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: context.myTheme.colorScheme.foreground,
                              )),
                          const SizedBox(width: 24),
                          SvgPicture.asset(
                              "assets/icons/ic_product_bookmark.svg",
                              colorFilter: ColorFilter.mode(
                                context.myTheme.colorScheme.foreground,
                                BlendMode.srcIn,
                              )),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        product.description,
                        style: context.myTheme.textThemeT1.body.copyWith(
                          fontSize: 18,
                          color: context.myTheme.colorScheme.foreground,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ExpandableWidget(
                        title: 'Specs',
                        body: product.description,
                      ),
                      ExpandableWidget(
                        title: 'Buy Here',
                        body: product.description,
                      ),
                      ExpandableWidget(
                        title: 'What we like',
                        body: product.description,
                      ),
                      ExpandableWidget(
                        title: 'What we don’t like',
                        body: product.description,
                      ),
                      const SizedBox(height: 24),
                      _buildImageGallery(),
                      // ListView.separated(
                      //     shrinkWrap: true,
                      //     padding: const EdgeInsets.only(top: 16),
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemBuilder: (context, index) {
                      //       return ClipRRect(
                      //         borderRadius: BorderRadius.circular(4),
                      //         child: AspectRatio(
                      //           aspectRatio: 1,
                      //           child: Container(
                      //             width: double.infinity,
                      //             color: context.myTheme.colorScheme.primary,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) {
                      //       return const SizedBox(height: 8);
                      //     },
                      //     itemCount: 5)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 10,
          child: GestureDetector(
            onTap: () => context.router.maybePop(),
            child: SvgPicture.asset(
              "assets/icons/ic_close.svg",
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageGallery() {
    List<String> galleryImages = product.images.isNotEmpty
        ? product.images
        : List.generate(
            5, (index) => 'https://picsum.photos/400/400?random=$index');

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: context.myTheme.colorScheme.primary,
              ),
              child: product.images.isNotEmpty
                  ? ProductExtendedImage(
                      imageUrl: product.images[index],
                      width: double.infinity,
                      onTap: () => ExtendedImageGalleryViewer.showAsDialog(
                          context,
                          images: product.images,
                          initialIndex: index),
                      borderRadius: BorderRadius.circular(4),
                    )
                  : null,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
      itemCount: galleryImages.length,
    );
  }

  Widget _buildMainProductImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      child: ClipRRect(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.primary,
            ),
            child: product.images.isNotEmpty
                ? ProductExtendedImage(
                    imageUrl: product.images.first,
                    width: double.infinity,
                    onTap: () => ExtendedImageGalleryViewer.showAsDialog(
                        context,
                        images: product.images,
                        initialIndex: 0),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color: context.myTheme.colorScheme.separator1,
            width: 1,
          )),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(widget.title,
                        style: context.myTheme.textThemeT1.title.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: context.myTheme.colorScheme.foreground,
                        ))),
                SvgPicture.asset("assets/icons/ic_product_plus.svg",
                    colorFilter: ColorFilter.mode(
                      context.myTheme.colorScheme.iconInactive,
                      BlendMode.srcIn,
                    )),
              ],
            ),
            if (_isExpanded) ...{
              const SizedBox(height: 8),
              Text(
                widget.body,
                style: context.myTheme.textThemeT1.body.copyWith(
                  fontSize: 16,
                  color: context.myTheme.colorScheme.foreground,
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
