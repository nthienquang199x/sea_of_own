import 'package:app_base/app/config/routes.dart';
import 'package:app_base/features/products/products_page.dart';
import 'package:app_base/features/splash/splash_page.dart';
import 'package:app_base/models/category.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../base/base_state.dart';
import 'app_cubit.dart';
import 'app_state.dart';

@RoutePage()
class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends BaseState<AppState, AppCubit, AppPage> {
  @override
  bool get isCloseCubit => false;

  @override
  void initState() {
    cubit.init(context: context);
    super.initState();
  }

  @override
  onStateChanged(AppState previous, AppState current) {
    if (current.user != null) {
      context.router.replaceNamed(Routes.home);
    }
    return super.onStateChanged(previous, current);
  }

  @override
  Widget buildByState(BuildContext context, AppState state) {
    switch (state.status) {
      case PageStatus.loading:
        return const SplashPage();
      case PageStatus.idle:
        // return ProductPage(
        //   product: Product(
        //     id: '1',
        //     name: 'Oblong Watch',
        //     price: 450.00,
        //     currency: 'CA\$',
        //     description:
        //         'Oblong is a bold, contemporary take on the classic rectangular timepiece. A hybrid of past and present with a modernist edge.',
        //     images: [
        //       'https://example.com/watch1.jpg',
        //       'https://example.com/watch2.jpg',
        //       'https://example.com/watch3.jpg',
        //     ],
        //     category: 'Watches',
        //     isAvailable: true,
        //     createdAt: DateTime.now().subtract(const Duration(days: 30)),
        //     updatedAt: DateTime.now(),
        //   ),
        // );
        return ProductsPage(
          category: Category(name: 'Watches'),
        );
      case PageStatus.error:
        return Container();
    }
  }
}
