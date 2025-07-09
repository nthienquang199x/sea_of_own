import 'package:app_base/app/config/routes.dart';
import 'package:app_base/features/home/presentation/home_page.dart';
import 'package:app_base/features/splash/splash_page.dart';
import 'package:auto_route/auto_route.dart';

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
      ];
}
