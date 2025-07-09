import 'package:app_base/core/localization/app_locale.dart';
import 'package:app_base/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              // App Name
              Text(
                'SeaOfOwn',
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
              // Continue with Apple Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Apple login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.myTheme.colorScheme.foreground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue with Apple',
                        style: context.myTheme.textThemeT1.title.copyWith(
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
              // Continue with Google Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Google login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.myTheme.colorScheme.foreground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue with Google',
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
