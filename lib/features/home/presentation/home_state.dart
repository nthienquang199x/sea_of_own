import 'package:app_base/core/network/models/category.dart';
import 'package:app_base/core/network/models/product.dart';
import 'package:app_base/core/network/models/space.dart';

class HomeState {
  final List<Category> categories;
  final List<Product> products;
  final List<Space> spaces;
  final int page;
  final int perPage;

  HomeState({
    this.categories = const [],
    this.products = const [],
    this.spaces = const [],
    this.page = 1,
    this.perPage = 10,
  });
  HomeState copyWith({
    List<Category>? categories,
    List<Product>? products,
    List<Space>? spaces,
    int? page,
    int? perPage,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      spaces: spaces ?? this.spaces,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }
}
