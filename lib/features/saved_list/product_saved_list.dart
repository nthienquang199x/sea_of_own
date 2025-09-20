import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/core/network/models/product.dart';
import 'package:app_base/features/home/components/custom_navigation_bar.dart';
import 'package:app_base/features/product/product_page.dart';
import 'package:app_base/features/products/models/sort_by.dart';
import 'package:app_base/features/profile/components/custom_bottom_sheet.dart';
import 'package:app_base/features/saved_list/saved_list_cubit.dart';
import 'package:app_base/features/saved_list/saved_list_state.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/custom_extended_image.dart';
import 'package:app_base/utils/widget/custom_radio_group.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home/models/navigation_type.dart';

@RoutePage()
class ProductSavedListPage extends StatefulWidget {
  const ProductSavedListPage(
      {super.key, required this.id, this.title = "Default List"});
  final int id;
  final String title;

  @override
  State<ProductSavedListPage> createState() => _ProductSavedListPageState();
}

class _ProductSavedListPageState
    extends BaseState<SavedListState, SavedListCubit, ProductSavedListPage> {
  @override
  void initState() {
    cubit.getAllProductsInCollection(widget.id);
    super.initState();
  }

  @override
  Widget buildByState(BuildContext context, SavedListState state) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      bottomNavigationBar: CustomNavigationBar(
        type: NavigationType.bookmarks,
        onTap: (type) {
          context.maybePop(type);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => context.router.maybePop(),
                      child: SvgPicture.asset(
                        "assets/icons/ic_chevron_left.svg",
                        colorFilter: ColorFilter.mode(
                          context.myTheme.colorScheme.foreground,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: context.myTheme.textThemeT1.title.copyWith(
                            color: context.myTheme.colorScheme.foreground,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => buildFilter(),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: context.myTheme.colorScheme.menuIconBg,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/ic_products_sort.svg",
                            colorFilter: ColorFilter.mode(
                              context.myTheme.colorScheme.foreground,
                              BlendMode.srcIn,
                            ),
                          )),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => buildOptionDialog(),
                        ).then((value) {
                          if (value != null && value is Map<String, dynamic>) {
                            if (value['deleted'] == true) {
                              context.router.maybePop(true);
                            }
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.menuIconBg,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/icons/ic_menu.svg",
                            colorFilter: ColorFilter.mode(
                              context.myTheme.colorScheme.foreground,
                              BlendMode.srcIn,
                            )),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return buildProductCard(product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     leadingWidth: 40,
  //     leading: GestureDetector(
  //       onTap: () {
  //         context.router.maybePop();
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 16),
  //         child: SvgPicture.asset(
  //           "assets/icons/ic_chevron_left.svg",
  //           colorFilter: ColorFilter.mode(
  //             context.myTheme.colorScheme.foreground,
  //             BlendMode.srcIn,
  //           ),
  //         ),
  //       ),
  //     ),
  //     title: Text(
  //       'Default List',
  //       style: context.myTheme.textThemeT1.title.copyWith(
  //           color: context.myTheme.colorScheme.foreground,
  //           fontWeight: FontWeight.w500),
  //     ),
  //     actions: [
  //       GestureDetector(
  //         onTap: () {
  //           showDialog(
  //             context: context,
  //             builder: (context) => buildFilter(),
  //           );
  //         },
  //         child: Container(
  //             decoration: BoxDecoration(
  //               color: context.myTheme.colorScheme.menuIconBg,
  //               shape: BoxShape.circle,
  //             ),
  //             child: SvgPicture.asset(
  //               "assets/icons/ic_products_sort.svg",
  //               colorFilter: ColorFilter.mode(
  //                 context.myTheme.colorScheme.foreground,
  //                 BlendMode.srcIn,
  //               ),
  //             )),
  //       ),
  //       const SizedBox(width: 12),
  //       GestureDetector(
  //         onTap: () {
  //           showModalBottomSheet(
  //             context: context,
  //             builder: (context) => buildOptionDialog(),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: context.myTheme.colorScheme.menuIconBg,
  //             shape: BoxShape.circle,
  //           ),
  //           child: SvgPicture.asset("assets/icons/ic_menu.svg",
  //               colorFilter: ColorFilter.mode(
  //                 context.myTheme.colorScheme.foreground,
  //                 BlendMode.srcIn,
  //               )),
  //         ),
  //       ),
  //       const SizedBox(width: 12),
  //     ],
  //     backgroundColor: context.myTheme.colorScheme.muted,
  //   );
  // }

  Widget buildProductCard(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              cubit.upsertRecentlyViewed(
                product.id,
              );
              return ProductPage(productId: product.id);
            },
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              // child: Image.asset(
              //   product.url ?? "assets/images/img_product_placeholder.png",
              //   fit: BoxFit.cover,
              //   height: 114,
              // ),
              child: ProductExtendedImage(
                imageUrl: product.thumbnail ?? '',
                width: 114,
                height: 114,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: context.myTheme.textThemeT1.title.copyWith(
                        color: context.myTheme.colorScheme.textColor,
                      ),
                    ),
                    Text(
                      '${product.currency.symbol ?? '\$'}${product.price}',
                      style: context.myTheme.textThemeT1.body.copyWith(
                        color: context.myTheme.colorScheme.mutedForeground,
                      ),
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

  Widget buildFilter() {
    return StatefulBuilder(builder: (context, setStateBuilder) {
      return CustomBottomSheet(
          title: AppLocale.sort_by,
          titleButton: AppLocale.sort,
          onTap: () {
            cubit.getAllProductsInCollection(widget.id);
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomRadioGroup<SortBy>(
              selected: state.sortBy,
              options: SortBy.values,
              itemLabelBuilder: (option) => option.displayName.tr(context),
              onChanged: (value) {
                setStateBuilder(() {
                  cubit.updateSortBy(value ?? SortBy.createdAt);
                });
              },
            ),
          ));
    });
  }

  Widget buildOptionDialog() {
    return CustomBottomSheet(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGroup([
          _buildItem(
            AppLocale.rename,
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              color: context.myTheme.colorScheme.separator1,
              height: 1,
            ),
          ),
          _buildItem(AppLocale.delete_this_list,
              textColor: context.myTheme.colorScheme.destructive, onTap: () {
            cubit.deleteCollection(widget.id).then(
              (value) {
                context.router.maybePop({
                  'deleted': true,
                });
              },
            );
          })
        ]),
      ],
    ));
  }

  Widget _buildGroup(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildItem(
    String title, {
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.tr(context),
              style: context.myTheme.textThemeT1.title.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor ?? context.myTheme.colorScheme.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
