import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_vaksin_web/core/data_wrapper.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/lat_long.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/location.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';

class AddVaccinePlaceController extends GetxController {
  final VaccinePlaceDataSource _vaccinePlaceDataSource;

  AddVaccinePlaceController(this._vaccinePlaceDataSource);

  final placeTextEditingController = TextEditingController();

  final location = Rx<Location?>(null);

  final currentStartDate = DateTime.now().obs;

  final currentEndDate = DateTime.now().add(const Duration(days: 14)).obs;

  final address = DataWrapper<String>.init().obs;

  final coordinate = DataWrapper<LatLong>.init().obs;

  String get latitudeLongitude =>
      '${coordinate.value.data!.latitude}, ${coordinate.value.data!.longitude}';

  String get currentDateFilter =>
      '${currentStartDate.value.toDayMonthYearFormat} - ${currentEndDate.value.toDayMonthYearFormat}';

  void onChangeDateFilter(DateTime? startDate, DateTime? endDate) {
    if (startDate != null) {
      currentStartDate.value = startDate;
    }
    if (endDate != null) {
      currentEndDate.value = endDate;
    }
  }

  String? isPlaceFieldValid(String? value) {
    if (value == null && value!.isEmpty) {
      return 'Lokasi tidak boleh kosong';
    }
    return null;
  }

  void onSelectLocation(Location value) {
    location.value = value;
    placeTextEditingController.text = value.name;
  }

  void processLocationId() async {
    address.value = DataWrapper.loading();
    coordinate.value = DataWrapper.loading();

    var latLong = await _vaccinePlaceDataSource.getLatLong(location.value!.id);
    var completeAddress = await _vaccinePlaceDataSource.getCompleteAddress(
        latLong.latitude, latLong.longitude);

    coordinate.value = DataWrapper.success(latLong);
    address.value = DataWrapper.success(completeAddress);
  }

  Future<List<Location>> fetchLocationList(String query) async {
    var x = await _vaccinePlaceDataSource.getPlaceList(query);
    debugPrint('LENGTHH: ${x.length}');
    return x;
  }

  @override
  void onInit() {
    super.onInit();
    placeTextEditingController.addListener(() {
      if (placeTextEditingController.text.isEmpty) {
        address.value = DataWrapper.init();
        coordinate.value = DataWrapper.init();
      }
    });
    ever(location, (_) {
      processLocationId();
    });
  }
}
