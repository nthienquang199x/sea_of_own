import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_base/app/app/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';

import 'app/app/app_cubit.dart';
import 'app/config/app_config.dart';
import 'core/localization/app_locale.dart';
import 'core/storage/local_storage.dart';
import 'di/injector.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  runZonedGuarded(() async {
    HttpOverrides.global = MyHttpOverrides();
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    // Khởi tạo Firebase với xử lý lỗi
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
    } catch (e) {}
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await LocalStorage().init();
    configureDependencies(AppConfig.prod());
    // Init

    // Force portrait orientation
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    FlutterNativeSplash.remove();
    runApp(const MainPage());
  }, (error, stackTrace) {
    log("runZonedGuarded() $error", error: error, stackTrace: stackTrace);
  });
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AppLocale {
  final appCubit = GetIt.instance<AppCubit>();

  @override
  void initState() {
    init(
        mapLocales: [AppLanguage.en.defaultLocale],
        initLanguage: AppLanguage.en);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return ToastificationWrapper(
            child: BlocProvider.value(
          value: getIt<AppCubit>(),
          child: BlocListener<AppCubit, AppState>(
            listenWhen: (previous, current) =>
                previous.appTheme != current.appTheme,
            listener: (context, state) {
              return setState(() {});
            },
            child: MaterialApp.router(
              title: 'SeaOfOwn',
              debugShowCheckedModeBanner: false,
              builder: FlutterSmartDialog.init(
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: ResponsiveBreakpoints.builder(breakpoints: [
                    const Breakpoint(start: 0, end: 450, name: MOBILE),
                    const Breakpoint(start: 451, end: 800, name: TABLET),
                    const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  ], child: child!),
                ),
              ),
              routerDelegate:
                  appCubit.appRouter.delegate(navigatorObservers: () {
                return [FlutterSmartDialog.observer];
              }),
              supportedLocales: localization.supportedLocales,
              localizationsDelegates: localization.localizationsDelegates,
              routeInformationParser: appCubit.appRouter.defaultRouteParser(),
              theme: appCubit.state.appTheme.themeData,
            ),
          ),
        ));
      },
    );
  }

  @override
  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }
}
