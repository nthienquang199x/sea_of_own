import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String root = "/";
  static const String home = "/home";
  static const String splash = "/splash";
  static const String profile = "/profile";
  static const String products = "/products";
  static const String productDetails = "/product-details";
  static const String productSavedList = "/product-saved-list";
  static const String search = "/search";
  static const String category = "/category";
  static const String login = "/login";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}
