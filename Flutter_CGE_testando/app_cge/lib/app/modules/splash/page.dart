import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_cge/app/modules/login/page.dart';
import 'package:app_cge/app/modules/splash/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/image/loading.json'),
      backgroundColor: Colors.white,
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      splashIconSize: 250,
      duration: 4000,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
