import 'package:app_base/app/config/app_router.dart';
import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/core/network/base/api_client.dart';
import 'package:app_base/features/product/product_page.dart';
import 'package:app_base/features/profile/presentation/profile_page.dart';
import 'package:app_base/features/saved_list/saved_list_page.dart';
import 'package:app_base/features/search/presentation/search_page.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/custom_navigation_bar.dart';
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
  @override
  void initState() {
    cubit.fetchCategories();
    cubit.fetchProducts();
    cubit.fetchSpaces();
    super.initState();
  }

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
        return SearchPage(
          onTapNavigation: (type) {
            setState(() {
              currentType = type;
            });
          },
        );
      case NavigationType.bookmarks:
        return SavedListPage(
          onTapNavigation: (type) {
            setState(() {
              currentType = type;
            });
          },
        );
      case NavigationType.profile:
        return const ProfilePage();
    }
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              AppLocale.sea_of_own.tr(context),
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
            height: state.products.isNotEmpty ? 330 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: PageView.builder(
              itemCount: state.products.length,
              padEnds: false,
              controller: PageController(viewportFraction: 1),
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
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
                                aspectRatio: 396 / 295,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: product.images != null &&
                                            product.images!.isNotEmpty
                                        ? product.images!.first.url
                                        : 'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  // child: Container(
                                  //   decoration: const BoxDecoration(
                                  //     color: Colors.red,
                                  //   ),
                                  //   child: Center(
                                  //     child: Icon(
                                  //       Icons.build,
                                  //       size: 60,
                                  //       color: Colors.grey[400],
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        product.name,
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
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

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
              height: state.products.isNotEmpty ? 194 : 0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
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
                                child: CachedNetworkImage(
                                  imageUrl: product.images != null &&
                                          product.images!.isNotEmpty
                                      ? product.images!.first.url
                                      : 'https://via.placeholder.com/150',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                // child: Container(
                                //   decoration: BoxDecoration(
                                //     color: Colors.grey[200],
                                //   ),
                                //   child: Center(
                                //     child: Icon(
                                //       Icons.build,
                                //       size: 60,
                                //       color: Colors.grey[400],
                                //     ),
                                //   ),
                                // ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        style: context.myTheme.textThemeT1.body
                                            .copyWith(
                                          color: context
                                              .myTheme.colorScheme.foreground,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                      style: context.myTheme.textThemeT1.bigTitle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: context.myTheme.colorScheme.cardForeground,
                      )),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.categories.length,
                    separatorBuilder: (context, index) => Divider(
                      color: context.myTheme.colorScheme.separator2,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return InkWell(
                        onTap: () {
                          context.router
                              .push(
                            ProductsRoute(
                              category: category,
                            ),
                          )
                              .then((value) {
                            if (value != null && value is NavigationType) {
                              setState(() {
                                currentType = value;
                              });
                            }
                          });
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
              height: state.spaces.isNotEmpty ? 194 : 0,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: state.spaces.length,
                itemBuilder: (context, index) {
                  final space = state.spaces[index];
                  return InkWell(
                    onTap: () {
                      // showModalBottomSheet(
                      //   isScrollControlled: true,
                      //   backgroundColor: Colors.transparent,
                      //   context: context,
                      //   builder: (context) => ProductPage(product: product),
                      // );
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
                                child: CachedNetworkImage(
                                  imageUrl: space.thumnail ??
                                      'https://via.placeholder.com/150',
                                  fit: BoxFit.cover,
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
                                // child: Container(
                                //   decoration: BoxDecoration(
                                //     color: Colors.grey[200],
                                //   ),
                                //   child: Center(
                                //     child: Icon(
                                //       Icons.build,
                                //       size: 60,
                                //       color: Colors.grey[400],
                                //     ),
                                //   ),
                                // ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        space.name,
                                        style: context.myTheme.textThemeT1.title
                                            .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: context
                                              .myTheme.colorScheme.foreground,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
    return CustomNavigationBar(
      type: currentType,
      onTap: (type) {
        setState(() {
          currentType = type;
        });
      },
    );
  }
}
