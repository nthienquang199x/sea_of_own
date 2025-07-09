import 'package:app_base/utils/extension/context_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.myTheme.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/app_icon.svg",
            width: 200,
          ),
        ),
      ),
    );
  }
}
