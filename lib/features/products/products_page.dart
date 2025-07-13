import 'package:app_base/features/product/product_page.dart';
import 'package:app_base/models/category.dart';
import 'package:app_base/models/product.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.category});
  final Category category;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Bulbul-Oblong',
      price: 450.00,
      currency: 'CA\$',
      description:
          'Oblong is a bold, contemporary take on the classic rectangular timepiece. A hybrid of past and present with a modernist edge.',
      images: [
        'https://example.com/watch1.jpg',
        'https://example.com/watch2.jpg',
        'https://example.com/watch3.jpg',
      ],
      category: 'Watches',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '2',
      name: 'Classic Elegance',
      price: 520.00,
      currency: 'CA\$',
      description:
          'A timeless piece that combines traditional craftsmanship with modern design elements.',
      images: [
        'https://example.com/watch4.jpg',
        'https://example.com/watch5.jpg',
      ],
      category: 'Watches',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '3',
      name: 'Sport Pro',
      price: 380.00,
      currency: 'CA\$',
      description:
          'Designed for active lifestyles with water resistance and durable materials.',
      images: [
        'https://example.com/watch6.jpg',
        'https://example.com/watch7.jpg',
        'https://example.com/watch8.jpg',
      ],
      category: 'Watches',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '4',
      name: 'Minimalist',
      price: 295.00,
      currency: 'CA\$',
      description:
          'Clean lines and subtle sophistication define this understated timepiece.',
      images: [
        'https://example.com/watch9.jpg',
      ],
      category: 'Watches',
      isAvailable: false,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now(),
    ),
    Product(
      id: '5',
      name: 'Vintage Heritage',
      price: 680.00,
      currency: 'CA\$',
      description:
          'Inspired by classic designs from the golden age of horology.',
      images: [
        'https://example.com/watch10.jpg',
        'https://example.com/watch11.jpg',
      ],
      category: 'Watches',
      isAvailable: true,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
                child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 200 / 261,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => ProductPage(product: product),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.myTheme.colorScheme.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                child: Container())),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.name,
                                style:
                                    context.myTheme.textThemeT1.title.copyWith(
                                  color: context.myTheme.colorScheme.foreground,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${product.currency} ${product.price.toStringAsFixed(2)}',
                                style:
                                    context.myTheme.textThemeT1.title.copyWith(
                                  color: context
                                      .myTheme.colorScheme.mutedForeground,
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
            ))
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      leading: GestureDetector(
        onTap: () => context.router.maybePop(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(
            "assets/icons/ic_chevron_left.svg",
            colorFilter: ColorFilter.mode(
              context.myTheme.colorScheme.foreground,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      title: Text(
        widget.category.name,
        style: context.myTheme.textThemeT1.title.copyWith(
            color: context.myTheme.colorScheme.foreground,
            fontWeight: FontWeight.w500),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const FilterWidget();
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.menuIconBg,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/ic_products_filter.svg",
                colorFilter: ColorFilter.mode(
                  context.myTheme.colorScheme.foreground,
                  BlendMode.srcIn,
                )),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {},
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
        const SizedBox(width: 16),
      ],
      backgroundColor: context.myTheme.colorScheme.muted,
    );
  }
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool onSale = false;
  bool recentlyAdded = false;
  double priceRange = 0.5;
  bool viewAll = true;

  // Categories list
  final List<Category> categories = [
    Category(name: 'Computing'),
    Category(name: 'Speakers'),
    Category(name: 'Headphones'),
    Category(name: 'Cameras'),
    Category(name: 'Drones'),
    Category(name: 'Smart devices'),
    Category(name: 'Charging & Cables'),
  ];

  // Track selected categories
  final Map<String, bool> selectedCategories = {};
  final Map<String, String> categoryCounts = {
    'Computing': '8',
    'Speakers': '24',
    'Headphones': '12',
    'Cameras': '6',
    'Drones': '20',
    'Smart devices': '11',
    'Charging & Cables': '32',
  };

  @override
  void initState() {
    super.initState();
    // Initialize selected categories
    for (var category in categories) {
      selectedCategories[category.name] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Office',
            style: context.myTheme.textThemeT1.title.copyWith(
              color: context.myTheme.colorScheme.foreground,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.muted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildFilterRow('On Sale', '14', onSale, (value) {
                  setState(() => onSale = value);
                }),
                const Divider(height: 24),
                _buildFilterRow('Recently Added', '8', recentlyAdded, (value) {
                  setState(() => recentlyAdded = value);
                }),
                const Divider(height: 24),
                _buildPriceRangeRow(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.myTheme.colorScheme.muted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildFilterRow('View all', '', viewAll, (value) {
                  setState(() => viewAll = value);
                }, showCheckbox: true),
                const Divider(height: 24),
                ...categories.asMap().entries.map((entry) {
                  final category = entry.value;
                  final isLast = entry.key == categories.length - 1;
                  return Column(
                    children: [
                      _buildFilterRow(
                          category.name,
                          categoryCounts[category.name] ?? '0',
                          selectedCategories[category.name] ?? false, (value) {
                        setState(
                            () => selectedCategories[category.name] = value);
                      }),
                      if (!isLast) const Divider(height: 24),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: context.myTheme.colorScheme.muted,
                    borderRadius: BorderRadius.circular(25),
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
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: context.myTheme.colorScheme.foreground,
                    borderRadius: BorderRadius.circular(25),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow(
      String title, String count, bool value, Function(bool) onChanged,
      {bool showCheckbox = false}) {
    return Row(
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.myTheme.colorScheme.mutedForeground
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count,
                  style: context.myTheme.textThemeT1.title.copyWith(
                    color: context.myTheme.colorScheme.mutedForeground,
                    fontSize: 12,
                  ),
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
                      .withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRangeRow() {
    return Column(
      children: [
        Row(
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
              'Any',
              style: context.myTheme.textThemeT1.title.copyWith(
                color: context.myTheme.colorScheme.mutedForeground,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: context.myTheme.colorScheme.foreground,
            inactiveTrackColor:
                context.myTheme.colorScheme.mutedForeground.withOpacity(0.3),
            thumbColor: context.myTheme.colorScheme.foreground,
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: priceRange,
            onChanged: (value) {
              setState(() => priceRange = value);
            },
          ),
        ),
      ],
    );
  }
}
