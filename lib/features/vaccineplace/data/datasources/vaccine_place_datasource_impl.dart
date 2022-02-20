import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/datasources/vaccine_place_datasource.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/lat_long.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/location.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/data/models/vaccine_place.dart';

import '../../../../core/error.dart';
import '../../../../core/key.dart';

const googleBaseUrl = 'https://maps.googleapis.com/maps/api/';

class VaccinePlaceDataSourceImpl extends VaccinePlaceDataSource {
  final Dio dio;

  VaccinePlaceDataSourceImpl(this.dio);

  @override
  Future<List<VaccinePlace>> getVaccinePlaceList(
      String startDate, String endDate) async {
    try {
      var response = await dio.get('admin/get-all-event',
          options: Options(headers: {
            'token':
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NDU0NTU3ODYsIm5hbWUiOiJOaWJzIiwicm9sZSI6InVzZXIiLCJzdWIiOjE3fQ.cFoqrLkeFqr-rfBA4gXpgAj72WyLrBeovxmWuJ4FsbY"
          }),
          queryParameters: {'startDate': startDate, 'endDate': endDate});
      return (response.data as List)
          .map((item) => VaccinePlace.fromJson(item))
          .toList();
    } on DioError catch (error) {
      var x = error;
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<String> getCompleteAddress(double latitude, double longitude) async {
    try {
      var response = await dio.fetch(RequestOptions(
          baseUrl: googleBaseUrl,
          path: 'geocode/json',
          queryParameters: {
            'latlng': '$latitude,$longitude',
            'key': placesApiKey
          }));
      return response.data['results'][0]['formatted_address'];
    } catch (error) {
      throw GeneralException(error.toString());
    }
  }

  @override
  Future<List<Location>> getPlaceList(String query) async {
    try {
      var response = await dio.fetch(RequestOptions(
          path: 'place/autocomplete/json',
          baseUrl: googleBaseUrl,
          queryParameters: {'input': query, 'key': placesApiKey}));
      return (response.data['predictions'] as List)
          .map((item) => Location.fromJson(item))
          .toList();
    } catch (error) {
      throw GeneralException(error.toString());
    }
  }

  @override
  Future<LatLong> getLatLong(String placeId) async {
    try {
      var response = await dio.fetch(RequestOptions(
          baseUrl: googleBaseUrl,
          queryParameters: {'place_id': placeId, 'key': placesApiKey},
          path: 'geocode/json'));
      return LatLong.fromJson(
          response.data['results'][0]['geometry']['location']);
    } catch (error) {
      throw GeneralException(error.toString());
    }
  }
}
