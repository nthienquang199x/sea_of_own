import 'package:app_base/app/theme/icons.dart';
import 'package:app_base/core/network/models/sub_category.dart';
import 'package:app_base/features/products/products_cubit.dart';
import 'package:app_base/features/products/products_state.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key, required this.cubit});
  final ProductsCubit cubit;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool viewAll = true;
  ScrollController scrollController = ScrollController();
  double maxHeightFactor = 0.6;
  bool hasExpanded = false;

  ProductsCubit get cubit => widget.cubit;
  ProductsState get state => cubit.state;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (!scrollController.position.atEdge && !hasExpanded) {
        setState(() {
          hasExpanded = true;
          maxHeightFactor = 0.8;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<SubCategory, String> subCategoryCounts = state.subCategories
        .asMap()
        .map((_, subCategory) => MapEntry(
            subCategory,
            state.products
                .where((product) => product.subCategory?.id == subCategory.id)
                .length
                .toString()));
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.ease,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.myTheme.colorScheme.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * maxHeightFactor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Filter',
                        style: context.myTheme.textThemeT1.title.copyWith(
                          color: context.myTheme.colorScheme.foreground,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.muted,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            _buildFilterRow(
                                title: 'On Sale',
                                count: state.products
                                    .where(
                                        (product) => product.isOnSale == true)
                                    .length
                                    .toString(),
                                value: state.onSale,
                                showCheckbox: state.onSale,
                                onChanged: (value) {
                                  cubit.toggleOnSale();
                                }),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(height: 24),
                            ),
                            _buildFilterRow(
                                title: 'Recently Added',
                                count: state.products.length.toString(),
                                value: state.recentlyAdded,
                                showCheckbox: state.recentlyAdded,
                                onChanged: (value) {
                                  cubit.toggleRecentlyAdded();
                                }),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(height: 24),
                            ),
                            _buildPriceRangeRow(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (state.subCategories.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: context.myTheme.colorScheme.muted,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              _buildFilterRow(
                                  title: 'View all',
                                  count: '',
                                  value: viewAll,
                                  onChanged: (value) {
                                    if (state
                                        .selectedSubCategories.isNotEmpty) {
                                      setState(() => viewAll = value);
                                      cubit.toogleViewAll();
                                    }
                                  },
                                  showCheckbox:
                                      state.selectedSubCategories.isEmpty),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Divider(height: 24),
                              ),
                              ...state.subCategories
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final category = entry.value;
                                final isLast =
                                    entry.key == state.subCategories.length - 1;
                                return Column(
                                  children: [
                                    _buildFilterRow(
                                        title: category.name,
                                        count:
                                            subCategoryCounts[category] ?? '0',
                                        value: state.selectedSubCategories
                                            .where((c) => c.id == category.id)
                                            .isNotEmpty,
                                        onChanged: (value) {
                                          setState(() => viewAll = false);
                                          cubit.selectSubCategory(category);
                                        },
                                        showCheckbox: true),
                                    if (!isLast)
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Divider(height: 24),
                                      ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => context.maybePop(false),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.muted,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Remove Filter',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              color: context.myTheme.colorScheme.foreground,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => context.maybePop(true),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.foreground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Apply Filter',
                            style: context.myTheme.textThemeT1.title.copyWith(
                              color: context.myTheme.colorScheme.background,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        Positioned(
          top: -30,
          right: 6,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(AppIcons.ic_close, width: 24, height: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterRow(
      {required String title,
      required String count,
      required bool value,
      required Function(bool) onChanged,
      bool showCheckbox = false}) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.myTheme.textThemeT1.title.copyWith(
                color: context.myTheme.colorScheme.foreground,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                if (count.isNotEmpty)
                  Text(
                    count,
                    style: context.myTheme.textThemeT1.body.copyWith(
                      color: context.myTheme.colorScheme.mutedForeground,
                    ),
                  ),
                const SizedBox(width: 8),
                if (showCheckbox)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: value
                          ? context.myTheme.colorScheme.foreground
                          : context.myTheme.colorScheme.mutedForeground,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: value
                        ? Icon(
                            Icons.check,
                            color: context.myTheme.colorScheme.background,
                            size: 16,
                          )
                        : null,
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: context.myTheme.colorScheme.mutedForeground
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRangeRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price Range',
                style: context.myTheme.textThemeT1.title.copyWith(
                  color: context.myTheme.colorScheme.foreground,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text(
                state.priceRange == state.maxPrice
                    ? 'Any'
                    : '\$ ${state.priceRange.toStringAsFixed(0)}',
                style: context.myTheme.textThemeT1.title.copyWith(
                  color: context.myTheme.colorScheme.mutedForeground,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: context.myTheme.colorScheme.foreground,
              inactiveTrackColor: context.myTheme.colorScheme.mutedForeground
                  .withValues(alpha: 0.3),
              thumbColor: context.myTheme.colorScheme.foreground,
              trackHeight: 4,
              overlayShape: SliderComponentShape.noOverlay,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              value: state.priceRange / state.maxPrice,
              onChanged: (value) {
                cubit.setPriceRange(value * state.maxPrice);
              },
            ),
          ),
        ),
      ],
    );
  }
}
