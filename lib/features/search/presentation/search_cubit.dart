import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/features/search/presentation/search_state.dart';
import 'package:app_base/models/category.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchCubit extends BaseCubit<SearchState> {
  SearchCubit() : super(SearchState());

  void init() {
    emit(state.copyWith(
      categories: categories,
    ));
  }

  void selectCategory(Category category) {
    emit(state.copyWith(categorySelected: category));
  }
}

final List<Category> categories = [
  Category(name: 'Tech & Audio'),
  Category(name: 'Tools'),
  Category(name: 'Work'),
  Category(name: 'Home'),
  Category(name: 'Personal'),
  Category(name: 'Craft'),
];
