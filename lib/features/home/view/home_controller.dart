import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/article/view/article_page.dart';
import 'package:yuk_vaksin_web/features/dashboard/view/dashboard_page.dart';
import 'package:yuk_vaksin_web/features/home/view/home_page.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/view/vaccine_place_page.dart';
import 'package:yuk_vaksin_web/features/vaccineregistration/view/vaccine_registration_page.dart';

import '../../vaccineschedule/view/vaccine_schedule_page.dart';

class HomeController extends GetxController {
  void onTapDashboardMenu(GetDelegate delegate) {
    delegate.toNamed(HomePage.routeName + DashboardPage.routeName);
  }

  void onTapVaccinePlaceMenu(GetDelegate delegate) {
    delegate.toNamed(HomePage.routeName + VaccinePlacePage.routeName);
  }

  void onTapVaccineScheduleMenu(GetDelegate delegate) {
    delegate.toNamed(HomePage.routeName + VaccineSchedulePage.routeName);
  }

  void onTapVaccineRegistrationMenu(GetDelegate delegate) {
    delegate.toNamed(HomePage.routeName + VaccineRegistrationPage.routeName);
  }

  void onTapArticleMenu(GetDelegate delegate) {
    delegate.toNamed(HomePage.routeName + ArticlePage.routeName);
  }
}
