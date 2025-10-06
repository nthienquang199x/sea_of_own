import 'package:app_base/app/config/routes.dart';
import 'package:app_base/core/network/models/category.dart';
import 'package:app_base/core/network/models/space.dart';
import 'package:app_base/core/network/models/sub_category.dart';
import 'package:app_base/features/home/presentation/home_page.dart';
import 'package:app_base/features/login/login_page.dart';
import 'package:app_base/features/products/products_page.dart';
import 'package:app_base/features/saved_list/product_saved_list.dart';
import 'package:app_base/features/splash/splash_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app/app_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            path: "/",
            page: AppRoute.page,
            initial: true,
            fullscreenDialog: true,
            children: const []),
        AutoRoute(
          path: Routes.splash,
          page: SplashRoute.page,
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: Routes.home,
        ),
        AutoRoute(
            page: ProductSavedListRoute.page, path: Routes.productSavedList),
        AutoRoute(
          page: ProductsRoute.page,
          path: Routes.products,
        ),
        AutoRoute(page: LoginRoute.page, path: Routes.login),
      ];
}
