import 'package:app_base/core/network/models/collection.dart';
import 'package:app_base/core/network/models/product.dart';

class ProductState {
  final List<Collection> collections;
  final List<Collection> selectedCollections;
  final Product? product;

  ProductState({
    this.collections = const [],
    this.selectedCollections = const [],
    this.product,
  });

  ProductState copyWith({
    List<Collection>? collections,
    List<Collection>? selectedCollections,
    Product? product,
  }) {
    return ProductState(
      collections: collections ?? this.collections,
      selectedCollections: selectedCollections ?? this.selectedCollections,
      product: product ?? this.product,
    );
  }
}
