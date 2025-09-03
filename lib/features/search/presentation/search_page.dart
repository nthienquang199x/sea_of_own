import 'package:app_base/app/config/app_router.dart';
import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/network/models/category.dart';
import 'package:app_base/core/network/models/product.dart';
import 'package:app_base/core/network/models/sub_category.dart';
import 'package:app_base/features/product/product_page.dart';
import 'package:app_base/features/search/components/search_widget.dart';
import 'package:app_base/features/search/presentation/search_cubit.dart';
import 'package:app_base/features/search/presentation/search_state.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../home/models/navigation_type.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.onTapNavigation});
  final Function(NavigationType type)? onTapNavigation;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends BaseState<SearchState, SearchCubit, SearchPage> {
  @override
  void initState() {
    cubit.addSearchListener();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.init();
    });
  }

  @override
  void dispose() {
    cubit.removeSearchListener();
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, SearchState state) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Search",
                style: context.myTheme.textThemeT1.title.copyWith(
                  color: context.myTheme.colorScheme.foreground,
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(height: 0),
            SearchWidget(
              searchController: cubit.searchController,
              searchText: state.searchText,
              onChanged: () {
                cubit.fetchProducts();
              },
            ),
            const SizedBox(height: 16),
            state.searchText.isNotEmpty
                ? buildContentAfterSearch()
                : buildContentBeforeSearch(),
          ],
        ),
      ],
    ));
  }

  Widget buildContentAfterSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.products.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
        itemBuilder: (context, index) {
          final product = state.products[index];
          return buildProductCard(product);
        },
      ),
    );
  }

  Widget buildContentBeforeSearch() {
    return Column(
      children: [
        const SizedBox(height: 8),
        SizedBox(
          height: state.categories.isNotEmpty ? 44 : 0,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final category = state.categories[index];
              final isSelected = category == state.categorySelected;
              return GestureDetector(
                onTap: () {
                  cubit.selectCategory(category);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.myTheme.colorScheme.foreground
                        : context.myTheme.colorScheme.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category.name,
                    style: context.myTheme.textThemeT1.body.copyWith(
                      color: isSelected
                          ? context.myTheme.colorScheme.background
                          : context.myTheme.colorScheme.foreground,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: context.myTheme.colorScheme.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.subCategoriesCategory.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(height: 1),
                  ),
                  itemBuilder: (context, index) {
                    final subCategory = state.subCategoriesCategory[index];
                    return buildCategoryCard(
                        subCategory, state.categorySelected!);
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Recently viewed",
                style: context.myTheme.textThemeT1.title.copyWith(
                  color: context.myTheme.colorScheme.foreground,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
                height: 136,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemCount: state.productsRecentlyViewed.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => ProductPage(
                              productId:
                                  state.productsRecentlyViewed[index].id),
                        );
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.myTheme.colorScheme.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: state
                                            .productsRecentlyViewed[index]
                                            .thumbnail ??
                                        '',
                                    fit: BoxFit.cover,
                                    height: 114,
                                    width: 114,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
            const SizedBox(height: 24),
          ],
        )
      ],
    );
  }

  Widget buildCategoryCard(SubCategory subCategory, Category category) {
    return InkWell(
      onTap: () {
        context.router
            .push(
          ProductsRoute(category: category),
        )
            .then((value) {
          if (value != null && value is NavigationType) {
            widget.onTapNavigation?.call(value);
          }
        });
      },
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subCategory.name,
              style: context.myTheme.textThemeT1.body.copyWith(
                color: context.myTheme.colorScheme.foreground,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/ic_home_arrow_right.svg",
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                context.myTheme.colorScheme.iconInactive,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard(Product product) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 80,
      ),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => ProductPage(productId: product.id),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                      product.price,
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
}
