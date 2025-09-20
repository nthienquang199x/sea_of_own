import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/core/network/models/category.dart';
import 'package:app_base/core/network/models/sub_category.dart';
import 'package:app_base/features/product/product_page.dart';
import 'package:app_base/features/products/components/filter_widget.dart';
import 'package:app_base/features/products/models/sort_option.dart';
import 'package:app_base/features/products/products_cubit.dart';
import 'package:app_base/features/products/products_state.dart';
import 'package:app_base/features/profile/components/custom_bottom_sheet.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:app_base/utils/widget/custom_radio_group.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../home/components/custom_navigation_bar.dart';
import '../home/models/navigation_type.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.category, this.subCategory});
  final Category category;
  final SubCategory? subCategory;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState
    extends BaseState<ProductsState, ProductsCubit, ProductsPage> {
  @override
  void initState() {
    cubit.init(widget.category.id, widget.subCategory?.id);
    super.initState();
  }

  @override
  Widget buildByState(BuildContext context, ProductsState state) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      // appBar: _buildAppBar(context),
      bottomNavigationBar: CustomNavigationBar(
        type: NavigationType.discover,
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
                        "Back",
                        style: context.myTheme.textThemeT1.title.copyWith(
                            color: context.myTheme.colorScheme.foreground,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return BlocBuilder<ProductsCubit, ProductsState>(
                              bloc: cubit,
                              builder: (contextB, state) {
                                return FilterWidget(
                                  cubit: cubit,
                                );
                              },
                            );
                          },
                        ).then((value) {
                          if (value == true) {
                            cubit.fetchProducts(
                                categoryId: widget.category.id,
                                sortDirection: state.sortDirection.name,
                                subCategoryId: widget.subCategory?.id);
                          } else if (value == false) {
                            cubit.onResetFilters();
                            cubit.fetchProducts(
                                categoryId: widget.category.id,
                                subCategoryId: widget.subCategory?.id);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.menuIconBg,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                            "assets/icons/ic_products_filter.svg",
                            height: 32,
                            width: 32,
                            colorFilter: ColorFilter.mode(
                              context.myTheme.colorScheme.foreground,
                              BlendMode.srcIn,
                            )),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => buildSortFilter(),
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
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.name,
                      style: context.myTheme.textThemeT1.title.copyWith(
                        color: context.myTheme.colorScheme.foreground,
                        fontWeight: FontWeight.w500,
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GridView.builder(
                      padding: const EdgeInsets.only(bottom: 200),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 200 / 261,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 16),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return GestureDetector(
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.myTheme.colorScheme.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                        child: Container(
                                          color: Colors.red,
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        product.name,
                                        style: context.myTheme.textThemeT1.title
                                            .copyWith(
                                          color: context
                                              .myTheme.colorScheme.foreground,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${product.currency.symbol ?? '\$'} ${product.price}',
                                        style: context.myTheme.textThemeT1.title
                                            .copyWith(
                                          color: context.myTheme.colorScheme
                                              .mutedForeground,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSortFilter() {
    return StatefulBuilder(builder: (context, setStateBuilder) {
      return CustomBottomSheet(
          title: AppLocale.sort_by,
          titleButton: AppLocale.sort,
          onTap: () {
            cubit.fetchProducts(
                categoryId: widget.category.id,
                sortDirection: state.sortDirection.name,
                subCategoryId: widget.subCategory?.id);
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomRadioGroup<SortOption>(
              selected: state.selectedSortOption,
              options: SortOption.values,
              itemLabelBuilder: (option) => option.displayName.tr(context),
              onChanged: (value) {
                setStateBuilder(() {
                  cubit.onChangeSortOption(value ?? SortOption.newlyAdded);
                });
              },
            ),
          ));
    });
  }

  // AppBar _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     leadingWidth: 40,
  //     leading: GestureDetector(
  //       onTap: () => context.router.maybePop(),
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
  //       widget.category.name,
  //       style: context.myTheme.textThemeT1.title.copyWith(
  //           color: context.myTheme.colorScheme.foreground,
  //           fontWeight: FontWeight.w500),
  //     ),
  //     actions: [
  //       GestureDetector(
  //         onTap: () {
  //           showModalBottomSheet(
  //             isScrollControlled: true,
  //             context: context,
  //             builder: (context) {
  //               return const FilterWidget();
  //             },
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: context.myTheme.colorScheme.menuIconBg,
  //             shape: BoxShape.circle,
  //           ),
  //           child: SvgPicture.asset("assets/icons/ic_products_filter.svg",
  //               colorFilter: ColorFilter.mode(
  //                 context.myTheme.colorScheme.foreground,
  //                 BlendMode.srcIn,
  //               )),
  //         ),
  //       ),
  //       const SizedBox(width: 12),
  //       GestureDetector(
  //         onTap: () {},
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
  //       const SizedBox(width: 16),
  //     ],
  //     backgroundColor: context.myTheme.colorScheme.muted,
  //   );
  // }
}
