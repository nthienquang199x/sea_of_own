// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppPage]
class AppRoute extends PageRouteInfo<void> {
  const AppRoute({List<PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [ProductSavedListPage]
class ProductSavedListRoute extends PageRouteInfo<ProductSavedListRouteArgs> {
  ProductSavedListRoute({
    Key? key,
    required int id,
    String title = "Default List",
    List<PageRouteInfo>? children,
  }) : super(
          ProductSavedListRoute.name,
          args: ProductSavedListRouteArgs(
            key: key,
            id: id,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductSavedListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductSavedListRouteArgs>();
      return ProductSavedListPage(
        key: args.key,
        id: args.id,
        title: args.title,
      );
    },
  );
}

class ProductSavedListRouteArgs {
  const ProductSavedListRouteArgs({
    this.key,
    required this.id,
    this.title = "Default List",
  });

  final Key? key;

  final int id;

  final String title;

  @override
  String toString() {
    return 'ProductSavedListRouteArgs{key: $key, id: $id, title: $title}';
  }
}

/// generated route for
/// [ProductsPage]
class ProductsRoute extends PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    Key? key,
    Category? category,
    SubCategory? subCategory,
    Space? space,
    List<PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(
            key: key,
            category: category,
            subCategory: subCategory,
            space: space,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductsRouteArgs>(
          orElse: () => const ProductsRouteArgs());
      return ProductsPage(
        key: args.key,
        category: args.category,
        subCategory: args.subCategory,
        space: args.space,
      );
    },
  );
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    this.key,
    this.category,
    this.subCategory,
    this.space,
  });

  final Key? key;

  final Category? category;

  final SubCategory? subCategory;

  final Space? space;

  @override
  String toString() {
    return 'ProductsRouteArgs{key: $key, category: $category, subCategory: $subCategory, space: $space}';
  }
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}
