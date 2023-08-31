import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';

import 'package:cge_app/app/modules/splash/splash_controller.dart';

import '../login/login_page.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/image/loading.json'),
      backgroundColor: Colors.white,
      nextScreen: const LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      splashIconSize: 250,
      duration: 4000,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
