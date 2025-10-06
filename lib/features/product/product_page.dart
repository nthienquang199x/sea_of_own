import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/core/network/models/image_model.dart';
import 'package:app_base/features/product/product_cubit.dart';
import 'package:app_base/features/product/product_state.dart';
import 'package:app_base/features/profile/components/custom_bottom_sheet.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/custom_extended_image.dart';
import 'package:app_base/utils/widget/extended_image_gallery_viewer.dart';
import 'package:app_base/utils/widget/spacer_widget.dart';
import 'package:app_base/utils/widget/text_form_field_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.productId});
  final int productId;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState
    extends BaseState<ProductState, ProductCubit, ProductPage> {
  bool _isDismissing = false;
  double _pullDistance = 0.0;
  static const double _dismissThreshold = 100.0;
  late ScrollController _scrollController;

  @override
  void initState() {
    cubit.init(widget.productId);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _shareProduct(ProductState state) async {
    if (state.product == null) return;

    final product = state.product!;
    final String shareText = '''
    ${product.name}
    ${product.brand?.name ?? ''}

    ${product.currency.symbol} ${product.salePrice}

    ${product.url ?? ''}
      ''';

    await SharePlus.instance.share(
      ShareParams(
        text: shareText,
        subject: product.name,
      ),
    );
  }

  @override
  Widget buildByState(BuildContext context, ProductState state) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: context.myTheme.colorScheme.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.axis == Axis.vertical) {
                if (notification is ScrollUpdateNotification) {
                  final pixels = notification.metrics.pixels;
                  final minExtent = notification.metrics.minScrollExtent;

                  if (pixels < minExtent) {
                    _pullDistance = (minExtent - pixels).abs();
                    if (_pullDistance > _dismissThreshold && !_isDismissing) {
                      _isDismissing = true;
                      context.router.maybePop();
                    }
                  } else {
                    _pullDistance = 0.0;
                  }
                }
                if (notification is ScrollEndNotification) {
                  _pullDistance = 0.0;
                  _isDismissing = false;
                }
              }

              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
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
                              child: Text(state.product?.brand?.name ?? '',
                                  style: context.myTheme.textThemeT1.title
                                      .copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        context.myTheme.colorScheme.foreground,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () => _shareProduct(state),
                              child: SvgPicture.asset(
                                "assets/icons/ic_product_share.svg",
                                colorFilter: ColorFilter.mode(
                                  context.myTheme.colorScheme.foreground,
                                  BlendMode.srcIn,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          state.product?.name ?? '',
                          style: context.myTheme.textThemeT1.title.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              color: context.myTheme.colorScheme.foreground),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              '${state.product?.currency.symbol ?? '\$'} ${state.product?.salePrice ?? '0'}',
                              style: context.myTheme.textThemeT1.title.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color:
                                      context.myTheme.colorScheme.foreground),
                            ),
                            if (state.product?.isOnSale == true) ...[
                              const HSpacing(
                                spacing: 16,
                              ),
                              Text(
                                '${state.product?.currency.symbol ?? '\$'} ${state.product?.price ?? '0'}',
                                style: context.myTheme.textThemeT1.title
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: context
                                            .myTheme.colorScheme.destructive,
                                        color: context
                                            .myTheme.colorScheme.destructive),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (state.product?.isLiked == true) {
                                  cubit.dislikeProduct(widget.productId);
                                  return;
                                }
                                cubit.likeProduct(widget.productId);
                              },
                              child: SvgPicture.asset(
                                  state.product?.isLiked == true
                                      ? "assets/icons/ic_product_heart_fill.svg"
                                      : "assets/icons/ic_product_heart.svg",
                                  height: 20,
                                  width: 20,
                                  colorFilter: ColorFilter.mode(
                                    context.myTheme.colorScheme.foreground,
                                    BlendMode.srcIn,
                                  )),
                            ),
                            const SizedBox(width: 8),
                            Text('${state.product?.totalLikes ?? 0}',
                                style:
                                    context.myTheme.textThemeT1.title.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: context.myTheme.colorScheme.foreground,
                                )),
                            const SizedBox(width: 24),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => BlocProvider.value(
                                    value: cubit,
                                    child: state.collections.isEmpty
                                        ? buildAddNewListDialog()
                                        : _buildChooseACollection(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                  state.product?.isCollected == true
                                      ? "assets/icons/ic_product_bookmark_fill.svg"
                                      : "assets/icons/ic_product_bookmark.svg",
                                  height: 20,
                                  width: 20,
                                  colorFilter: ColorFilter.mode(
                                    context.myTheme.colorScheme.foreground,
                                    BlendMode.srcIn,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          state.product?.description ?? '',
                          style: context.myTheme.textThemeT1.body.copyWith(
                            fontSize: 18,
                            color: context.myTheme.colorScheme.foreground,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ExpandableWidget(
                          title: AppLocale.specs.tr(context),
                          body: state.product?.spaces != null &&
                                  state.product!.spaces!.isNotEmpty
                              ? state.product!.spaces!
                                  .map((spec) => '${spec.name}: ${spec.name}')
                                  .join('\n')
                              : AppLocale.no_specifications_available
                                  .tr(context),
                        ),
                        ExpandableWidget(
                          title: AppLocale.buy_here.tr(context),
                          body: state.product?.description ?? '',
                        ),
                        ExpandableWidget(
                          title: AppLocale.what_we_like.tr(context),
                          body: state.product?.description ?? '',
                        ),
                        ExpandableWidget(
                          title: AppLocale.what_we_dont_like.tr(context),
                          body: state.product?.description ?? '',
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
        ),
        Positioned(
          top: 60,
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
    List<ImageModel>? galleryImages =
        state.product?.images != null && state.product!.images!.isNotEmpty
            ? state.product?.images
            : [];

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final imageUrl = state.product?.images?[index].url;
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: context.myTheme.colorScheme.primary,
              ),
              child: state.product?.images != null &&
                      state.product!.images!.isNotEmpty
                  ? ProductExtendedImage(
                      imageUrl: imageUrl ?? '',
                      width: double.infinity,
                      onTap: () => ExtendedImageGalleryViewer.showAsDialog(
                          context,
                          images:
                              state.product!.images!.map((e) => e.url).toList(),
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
      itemCount: galleryImages?.length ?? 0,
    );
  }

  Widget _buildChooseACollection() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return CustomBottomSheet(
          title: AppLocale.choose_a_collection,
          textColor: context.myTheme.colorScheme.muted,
          child: Container(
            padding: EdgeInsets.all(state.collections.isEmpty ? 0 : 24.0),
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final isSelected = state.product?.collections
                          ?.any((col) => col.id == state.collections[index].id);
                      return InkWell(
                        onTap: () {
                          if (isSelected == true) {
                            cubit.showToast(AppLocale
                                .removed_from_collection_successfully
                                .tr(context));
                            cubit.deleteProductFromCollections(
                                state.collections[index].id, widget.productId);
                          } else {
                            cubit.showToast(AppLocale
                                .saved_to_collection_successfully
                                .tr(context));
                            cubit.addProductToCollections(
                                [state.collections[index].id],
                                widget.productId);
                          }
                          context.router.maybePop();
                          // cubit.chooseCollections(state.collections[index]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                state.collections[index].name,
                                style:
                                    context.myTheme.textThemeT1.title.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: context.myTheme.colorScheme.foreground,
                                ),
                              ),
                            ),
                            isSelected == true
                                ? SvgPicture.asset(
                                    "assets/icons/ic_check.svg",
                                    colorFilter: ColorFilter.mode(
                                      context.myTheme.colorScheme.foreground,
                                      BlendMode.srcIn,
                                    ),
                                    fit: BoxFit.cover,
                                    height: 18,
                                    width: 18,
                                  )
                                : const SizedBox()
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: context.myTheme.colorScheme.separator1,
                      );
                    },
                    itemCount: state.collections.length)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAddNewListDialog() {
    return CustomBottomSheet(
        title: AppLocale.create_new_list,
        titleButton: AppLocale.create,
        child: TextFormFieldCustom(
          hintText: AppLocale.add_a_name.tr(context),
          borderColor: Colors.transparent,
          fillColor: context.myTheme.colorScheme.background,
          controller: cubit.createNameController,
          keyboardType: TextInputType.text,
          borderRadius: BorderRadius.circular(8),
          validators: [
            (value) {
              if (value == null || value.isEmpty) {
                return AppLocale.please_enter_a_name.tr(context);
              }
              return null;
            }
          ],
        ),
        onTap: () {
          cubit.createCollection().then((value) {
            context.router.maybePop();
          });
        });
  }

  Widget _buildMainProductImage() {
    return Container(
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: state.product?.images != null &&
                  state.product!.images!.isNotEmpty
              ? ProductExtendedImage(
                  imageUrl: state.product?.images?.first.url ?? '',
                  width: double.infinity,
                  onTap: () => ExtendedImageGalleryViewer.showAsDialog(context,
                      images:
                          state.product?.images!.map((e) => e.url).toList() ??
                              [],
                      initialIndex: 0),
                )
              : null,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
