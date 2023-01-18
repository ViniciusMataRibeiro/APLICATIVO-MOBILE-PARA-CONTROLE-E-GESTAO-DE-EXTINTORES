import 'package:app_cge/app/core/theme/app_theme.dart';
import 'package:app_cge/app/data/provider/api.dart';
import 'package:app_cge/app/data/services/auth/repository.dart';
import 'package:app_cge/app/data/services/auth/service.dart';
import 'package:app_cge/app/data/services/config/service.dart';
import 'package:app_cge/app/routes/pages.dart';
import 'package:app_cge/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

main() async {
  await GetStorage.init();
  Get.put<ConfigService>(ConfigService());
  Get.put<Api>(Api());
  Get.put<AuthService>(AuthService(AuthRepository(Get.find<Api>())));

  Intl.defaultLocale = 'pt_BR';

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.login,
    theme: themeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [
      Locale('pt', 'BR'),
    ],
  ));
}
