import 'package:app_base/app/config/routes.dart';
import 'package:app_base/base/base_state.dart';
import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/features/login/login_cubit.dart';
import 'package:app_base/features/login/login_state.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginState, LoginCubit, LoginPage> {
  @override
  void initState() {
    super.initState();
    cubit.stream.listen((state) {
      if (state.isSuccess && state.user != null) {
        context.router.replaceNamed(Routes.home);
      } else if (state.isError && state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget buildByState(BuildContext context, LoginState state) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              SvgPicture.asset("assets/icons/app_icon.svg", width: 239),
              const SizedBox(height: 32),
              Text(
                AppLocale.sea_of_own.tr(context),
                style:
                    context.myTheme.textThemeT1.bigTitle.copyWith(fontSize: 48),
              ),

              const SizedBox(height: 8),

              // Tagline
              Text(
                AppLocale.curated_objects_worth_keeping.tr(context),
                textAlign: TextAlign.center,
                style: context.myTheme.textThemeT1.title.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(flex: 3),
              if (Theme.of(context).platform == TargetPlatform.iOS)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state.isLoadingApple
                        ? null
                        : () async {
                            await cubit.loginWithApple();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.myTheme.colorScheme.foreground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: state.isLoadingApple
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocale.continue_with_apple.tr(context),
                                style:
                                    context.myTheme.textThemeT1.title.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: context.myTheme.colorScheme.background,
                                ),
                              ),
                              const SizedBox(width: 16),
                              SvgPicture.asset(
                                "assets/icons/ic_login_apple.svg",
                                colorFilter: ColorFilter.mode(
                                    context.myTheme.colorScheme.background,
                                    BlendMode.srcIn),
                              )
                            ],
                          ),
                  ),
                ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () async {
                          await cubit.loginWithGoogle();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.myTheme.colorScheme.foreground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: state.isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocale.continue_with_google.tr(context),
                              style: context.myTheme.textThemeT1.title.copyWith(
                                fontWeight: FontWeight.w500,
                                color: context.myTheme.isDark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            SvgPicture.asset("assets/icons/ic_login_google.svg")
                          ],
                        ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
