import 'package:app_base/base/base_cubit.dart';
import 'package:app_base/features/home/presentation/home_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());
}
