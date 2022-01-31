import 'package:doctor_appointment_booking/pages/on%20board/onboard1.dart';
import 'package:doctor_appointment_booking/pages/terms_and_conditions/terms%20and%20conditions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/home/home.dart';

import '../pages/language/change_laguage_page.dart';
import '../pages/login/login_page.dart';

import '../pages/notifications/notification_settings_page.dart';

import '../pages/signup/signup_page.dart';

import '../pages/splash_page.dart';

import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return CupertinoPageRoute(builder: (_) => SplashPage());

      case Routes.onboard:
        return CupertinoPageRoute(builder: (_) => onboard());

      case Routes.login:
        return CupertinoPageRoute(builder: (_) => LoginScreen());

      case Routes.home:
        return CupertinoPageRoute(builder: (_) => Home());

      case Routes.terms_and_conditions:
        return CupertinoPageRoute(builder: (_) => Termsandcondition());

      case Routes.changeLanguage:
        return CupertinoPageRoute(builder: (_) => ChangeLanguagePage());

      case Routes.notificationSettings:
        return CupertinoPageRoute(builder: (_) => NotificationSettingsPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
