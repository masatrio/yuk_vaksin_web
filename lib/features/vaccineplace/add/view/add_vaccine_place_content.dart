import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/view/add_vaccine_place_controller.dart';
import 'package:yuk_vaksin_web/widgets/vertical_title_value.dart';

import '../../../../core/base_color.dart';
import '../../../../core/data_wrapper.dart';
import '../../data/models/location.dart';

class AddVaccinePlaceContent extends GetView<AddVaccinePlaceController> {
  const AddVaccinePlaceContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalTitleValue(
                  title: 'Nama Tempat',
                  value: TypeAheadFormField(
                      validator: controller.isPlaceFieldValid,
                      textFieldConfiguration: TextFieldConfiguration(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        controller: controller.placeTextEditingController,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: 'Lokasi tempat vaksin',
                          labelStyle: TextStyle(
                            color: grey,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blue),
                          ),
                        ),
                      ),
                      onSuggestionSelected: (Location location) =>
                          controller.onSelectLocation(location),
                      itemBuilder: (context, Location location) {
                        return ListTile(
                          title: Text(location.name),
                        );
                      },
                      suggestionsCallback: (query) async {
                        if (query.isNotEmpty) {
                          return controller.fetchLocationList(query);
                        } else {
                          return const Iterable<Location>.empty();
                        }
                      }),
                ),
                const SizedBox(
                  height: 18,
                ),
                Obx(
                  () => VerticalTitleValue(
                      title: 'Alamat Lengkap', value: addressBody()),
                ),
                const SizedBox(
                  height: 18,
                ),
                Obx(
                  () => VerticalTitleValue(
                      title: 'Koordinat', value: coordinateBody()),
                ),
                const SizedBox(
                  height: 18,
                ),
                VerticalTitleValue(
                    title: 'Jadwal Tempat Vaksin',
                    value: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            var pickedDateRange = await showDateRangePicker(
                              context: context,
                              builder: (context, child) => Theme(
                                  data: ThemeData.light().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: blue)),
                                  child: Center(
                                    child: SizedBox(
                                      width: 400,
                                      height: 500,
                                      child: child,
                                    ),
                                  )),
                              initialDateRange: DateTimeRange(
                                  start: controller.currentStartDate.value,
                                  end: controller.currentEndDate.value),
                              firstDate: controller.currentStartDate.value
                                  .subtract(const Duration(days: 60)),
                              lastDate: controller.currentStartDate.value
                                  .add(const Duration(days: 365)),
                            );
                            controller.onChangeDateFilter(
                                pickedDateRange?.start, pickedDateRange?.end);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: grey),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Obx(() => Text(
                                          controller.currentDateFilter,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 14),
                                        )),
                                    const SizedBox(width: 12),
                                    const Icon(
                                      Icons.today,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              )),
                        )))
              ],
            )),
        const SizedBox(
          width: 36,
        ),
        Flexible(
            flex: 1,
            child: VerticalTitleValue(
              title: 'Lokasi dalam map',
              value: SizedBox(
                  width: 450, height: 230, child: Obx(() => googleMap())),
            ))
      ],
    );
  }

  Widget googleMap() {
    switch (controller.coordinate.value.status) {
      case Status.loading:
        return const SizedBox();
      case Status.success:
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              controller.coordinate.value.data!.latitude,
              controller.coordinate.value.data!.longitude,
            ),
            zoom: 15,
          ),
          markers: <Marker>{
            Marker(
                position: LatLng(
                  controller.coordinate.value.data!.latitude,
                  controller.coordinate.value.data!.longitude,
                ),
                markerId: const MarkerId("markerId"))
          },
        );
      case Status.error:
        return const SizedBox();
      case Status.init:
        return Container(
          decoration: const BoxDecoration(
              color: grey, borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_off,
                  size: 32,
                  color: blackGrey,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Silakan masukkan nama lokasi \nterlebih dahulu',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: blackGrey,
                      fontSize: 12),
                )
              ],
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget addressBody() {
    switch (controller.address.value.status) {
      case Status.loading:
        return Shimmer.fromColors(
            baseColor: blackGrey.withOpacity(0.3),
            highlightColor: shimmerColor,
            child: twoLinesShimmer());
      case Status.success:
        return Text(
          controller.address.value.data!,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
      case Status.error:
        return Text(
          '-',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
      case Status.init:
        return Text(
          '-',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
      default:
        return Text(
          '-',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
    }
  }

  Widget coordinateBody() {
    switch (controller.coordinate.value.status) {
      case Status.loading:
        return Shimmer.fromColors(
            baseColor: blackGrey.withOpacity(0.3),
            highlightColor: shimmerColor,
            child: twoLinesShimmer());
      case Status.success:
        return Text(
          controller.latitudeLongitude,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
      case Status.error:
        return Text(
          '-',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
      case Status.init:
        return Text(
          '-',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
      default:
        return Text(
          '-',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        );
    }
  }

  Widget twoLinesShimmer() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 24,
            color: Colors.white,
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: 50,
            height: 24,
            color: Colors.white,
          ),
        ],
      );
}
