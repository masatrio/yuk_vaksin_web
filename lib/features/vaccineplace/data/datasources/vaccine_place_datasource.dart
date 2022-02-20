import 'package:yuk_vaksin_web/features/vaccineplace/data/models/vaccine_place.dart';

import '../models/lat_long.dart';
import '../models/location.dart';

abstract class VaccinePlaceDataSource {
  Future<List<VaccinePlace>> getVaccinePlaceList(
      String startDate, String endDate);

  Future<List<Location>> getPlaceList(String query);

  Future<String> getCompleteAddress(double latitude, double longitude);

  Future<LatLong> getLatLong(String placeId);
}
