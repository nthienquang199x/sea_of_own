import 'dart:math' as math;

import 'package:app_base/app/config/app_router.dart';
import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/core/network/base/api_client.dart';
import 'package:app_base/features/product/product_page.dart';
import 'package:app_base/features/profile/presentation/profile_page.dart';
import 'package:app_base/features/saved_list/saved_list_page.dart';
import 'package:app_base/features/search/presentation/search_page.dart';
import 'package:app_base/models/category.dart';
import 'package:app_base/models/product.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/navigation_type.dart';
import 'home_cubit.dart';
import 'home_state.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomeState, HomeCubit, HomePage> {
  NavigationType currentType = NavigationType.discover;
  final List<Category> categories = [
    Category(name: 'Tech & Audio'),
    Category(name: 'Tools'),
    Category(name: 'Work'),
    Category(name: 'Home'),
    Category(name: 'Personal'),
    Category(name: 'Craft'),
  ];

  final product = Product(
    id: '3',
    name: 'Sport Pro',
    price: 380.00,
    currency: 'CA\$',
    description:
        'Designed for active lifestyles with water resistance and durable materials.',
    images: [
      'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2023/07/hinh-dep.jpg',
      'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2023/07/hinh-dep.jpg',
      'https://vn1.vdrive.vn/alohamedia.vn/2025/02/3xoqKJdm-24.jpg',
    ],
    category: 'Watches',
    isAvailable: true,
    createdAt: DateTime.now().subtract(const Duration(days: 20)),
    updatedAt: DateTime.now(),
  );

  void _onAuthenticationChanged() {
    if (!ApiClient.isAuthenticated.value) {}
  }

  @override
  void dispose() {
    ApiClient.isAuthenticated.removeListener(_onAuthenticationChanged);
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.muted,
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    switch (currentType) {
      case NavigationType.discover:
        return _buildHome();
      case NavigationType.search:
        return const SearchPage();
      case NavigationType.bookmarks:
        return const SavedListPage();
      case NavigationType.profile:
        return const ProfilePage();
    }
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 15),
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'SeaOfOwn',
              style: context.myTheme.textThemeT1.bigTitle.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: context.myTheme.colorScheme.foreground,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Featured Product
          Container(
            height: 320,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PageView.builder(
              itemCount: 5,
              padEnds: false,
              controller: PageController(viewportFraction: 1),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => ProductPage(product: product),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 396 / 353,
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 396 / 304,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.build,
                                      size: 60,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Hoto-12V Brushless Drill Tool Set',
                                      style: context.myTheme.textThemeT1.title
                                          .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: context
                                            .myTheme.colorScheme.foreground,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Newly Added Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(AppLocale.newly_added.tr(context),
                style: context.myTheme.textThemeT1.title.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.myTheme.colorScheme.foreground,
                )),
          ),
          const SizedBox(height: 16),
          SizedBox(
              height: 194,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => ProductPage(product: product),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 194 / 239,
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 194 / 188,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.build,
                                      size: 60,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Bulbul-Oblong',
                                      style: context.myTheme.textThemeT1.title
                                          .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: context
                                            .myTheme.colorScheme.foreground,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
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
          const SizedBox(height: 32),
          // Browse by categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.myTheme.colorScheme.card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocale.browse_by_categories.tr(context),
                      style: context.myTheme.textThemeT1.title.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: context.myTheme.colorScheme.cardForeground,
                      )),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => Divider(
                      color: context.myTheme.colorScheme.separator2,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return InkWell(
                        onTap: () {
                          context.router.push(
                            ProductsRoute(category: category),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.name,
                                style:
                                    context.myTheme.textThemeT1.title.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: context
                                      .myTheme.colorScheme.cardForeground,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/ic_home_arrow_right.svg',
                                colorFilter: ColorFilter.mode(
                                  context.myTheme.colorScheme.iconInactive,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(AppLocale.browse_by_spaces.tr(context),
                style: context.myTheme.textThemeT1.title.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.myTheme.colorScheme.foreground,
                )),
          ),
          const SizedBox(height: 16),
          SizedBox(
              height: 194,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => ProductPage(product: product),
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 194 / 239,
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.myTheme.colorScheme.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 194 / 188,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.build,
                                      size: 60,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Bulbul-Oblong',
                                      style: context.myTheme.textThemeT1.title
                                          .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: context
                                            .myTheme.colorScheme.foreground,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
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
          const SizedBox(height: 32),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         padding: const EdgeInsets.all(12),
          //         decoration: BoxDecoration(
          //           color: context.myTheme.colorScheme.surface,
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               height: 100,
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[200],
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             Text(
          //               'Bulbul-Oblong',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 color: context.myTheme.colorScheme.foreground,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: Container(
          //         padding: const EdgeInsets.all(12),
          //         decoration: BoxDecoration(
          //           color: context.myTheme.colorScheme.surface,
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               height: 100,
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[200],
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             Text(
          //               'RID Air Purifier',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 color: context.myTheme.colorScheme.foreground,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 24),

          // // Browse by categories
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: Colors.black87,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Browse by categories',
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.white,
          //         ),
          //       ),
          //       const SizedBox(height: 16),
          //       ...[
          //         'Tech & Audio',
          //         'Tools',
          //         'Work',
          //         'Home',
          //         'Personal',
          //         'Craft'
          //       ].map((category) => Padding(
          //             padding: const EdgeInsets.only(bottom: 12),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   category,
          //                   style: const TextStyle(
          //                     fontSize: 16,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //                 const Icon(
          //                   Icons.arrow_forward_ios,
          //                   size: 16,
          //                   color: Colors.white,
          //                 ),
          //               ],
          //             ),
          //           )),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 24),

          // // Browse by spaces
          // Text(
          //   'Browse by spaces',
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w600,
          //     color: context.myTheme.colorScheme.foreground,
          //   ),
          // ),
          // const SizedBox(height: 16),

          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         padding: const EdgeInsets.all(12),
          //         decoration: BoxDecoration(
          //           color: context.myTheme.colorScheme.surface,
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               height: 120,
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[200],
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             Text(
          //               'Night stand',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 color: context.myTheme.colorScheme.foreground,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 12),
          //     Expanded(
          //       child: Container(
          //         padding: const EdgeInsets.all(12),
          //         decoration: BoxDecoration(
          //           color: context.myTheme.colorScheme.surface,
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               height: 120,
          //               decoration: BoxDecoration(
          //                 color: Colors.grey[200],
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //             ),
          //             const SizedBox(height: 8),
          //             Text(
          //               'Shelves',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 color: context.myTheme.colorScheme.foreground,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 24),

          // // Shop gifts under $100
          // Container(
          //   width: double.infinity,
          //   height: 200,
          //   padding: const EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[200],
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Shop gifts under',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   color: Colors.grey[800],
          //                 ),
          //               ),
          //               const Text(
          //                 '\$100',
          //                 style: TextStyle(
          //                   fontSize: 32,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const Icon(
          //             Icons.arrow_forward,
          //             size: 24,
          //             color: Colors.black,
          //           ),
          //         ],
          //       ),
          //       const Spacer(),
          //       Container(
          //         height: 60,
          //         width: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.grey[400],
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: math.max(0, MediaQuery.of(context).padding.bottom - 4),
      ),
      decoration: BoxDecoration(
        color: context.myTheme.colorScheme.tab,
        boxShadow: [
          BoxShadow(
            color: context.myTheme.colorScheme.foreground.withValues(
              alpha: 0.1,
            ),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: NavigationType.values.map((e) {
          final isSelected = currentType == e;

          return GestureDetector(
            onTap: () {
              setState(() {
                currentType = e;
              });
            },
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  e.icon,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? context.myTheme.colorScheme.iconActive
                        : context.myTheme.colorScheme.iconInactive,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
