import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/view/add_vaccine_place_controller.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource_impl.dart';

import 'vaccine_place_controller.dart';

class VaccinePlaceBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.put<VaccinePlaceDataSource>(
          VaccinePlaceDataSourceImpl(Get.find<Dio>())),
      Bind.lazyPut(
          () => AddVaccinePlaceController(Get.find<VaccinePlaceDataSource>())),
      Bind.put<VaccinePlaceController>(
        VaccinePlaceController(Get.find<VaccinePlaceDataSource>()),
      )
    ];
  }
}
