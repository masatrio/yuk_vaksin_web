import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yuk_vaksin_web/features/home/view/home_binding.dart';
import 'package:yuk_vaksin_web/features/login/login_binding.dart';
import 'package:yuk_vaksin_web/features/login/login_page.dart';
import 'package:yuk_vaksin_web/features/vaccineregistration/view/vaccine_registration_page.dart';
import 'package:yuk_vaksin_web/features/vaccineschedule/view/vaccine_schedule_page.dart';
import 'package:yuk_vaksin_web/main_binding.dart';

import 'core/http_overrides.dart';
import 'features/article/view/article_page.dart';
import 'features/dashboard/view/dashboard_page.dart';
import 'features/home/view/home_page.dart';
import 'features/vaccineplace/view/vaccine_place_binding.dart';
import 'features/vaccineplace/view/vaccine_place_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  // HttpOverrides.global = MyHttpoverrides();
  // ByteData data =
  //     await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const YukVaksinWeb());
}

class YukVaksinWeb extends StatelessWidget {
  const YukVaksinWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: HomePage.routeName,
        defaultTransition: Transition.noTransition,
        initialBinding: MainBinding(),
        getPages: [
          GetPage(
              name: LoginPage.routeName,
              page: () => const LoginPage(),
              bindings: [LoginBinding()]),
          GetPage(
            name: HomePage.routeName,
            page: () => HomePage(),
            participatesInRootNavigator: true,
            bindings: [HomeBinding()],
            children: [
              GetPage(
                name: DashboardPage.routeName,
                transition: Transition.noTransition,
                page: () => const DashboardPage(),
              ),
              GetPage(
                  name: VaccinePlacePage.routeName,
                  transition: Transition.noTransition,
                  page: () => const VaccinePlacePage(),
                  bindings: [VaccinePlaceBinding()]),
              GetPage(
                name: VaccineSchedulePage.routeName,
                transition: Transition.noTransition,
                page: () => const VaccineSchedulePage(),
              ),
              GetPage(
                name: VaccineRegistrationPage.routeName,
                transition: Transition.noTransition,
                page: () => const VaccineRegistrationPage(),
              ),
              GetPage(
                name: ArticlePage.routeName,
                transition: Transition.noTransition,
                page: () => const ArticlePage(),
              ),
            ],
          )
        ]);
  }
}
