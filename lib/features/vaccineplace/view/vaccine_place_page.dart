import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/add/view/add_vaccine_place_content.dart';
import 'package:yuk_vaksin_web/features/vaccineplace/view/vaccine_place_controller.dart';
import 'package:yuk_vaksin_web/utils/date_util.dart';
import 'package:yuk_vaksin_web/widgets/loading_indicator.dart';
import 'package:yuk_vaksin_web/widgets/primary_button.dart';

import '../../../core/base_color.dart';
import '../../../core/data_wrapper.dart';

class VaccinePlacePage extends GetView<VaccinePlaceController> {
  static const routeName = '/vaccine-place';

  const VaccinePlacePage({Key? key}) : super(key: key);

  Widget body(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                addVaccinePlaceButton(context),
                const SizedBox(
                  width: 28,
                ),
                dateFilter(context),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(() => vaccinePlaceTable()),
          ],
        ),
      );

  void showAddVaccinePlaceButton(BuildContext context) => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Tambah tempat vaksin',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.black),
            ),
            content: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 1000,
                  minHeight: 200,
                ),
                child: const AddVaccinePlaceContent()),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ));

  Widget addVaccinePlaceButton(BuildContext context) => PrimaryButton(
      icon: const Icon(
        Icons.add,
        size: 16,
        color: Colors.white,
      ),
      onTap: () => showAddVaccinePlaceButton(context),
      label: 'Tambah');

  Widget dateFilter(BuildContext context) => MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          var pickedDateRange = await showDateRangePicker(
            context: context,
            builder: (context, child) => Theme(
                data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(primary: blue)),
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
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.today,
                    size: 16,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 12),
                  Obx(() => Text(
                        controller.currentDateFilter,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 14),
                      )),
                  const SizedBox(width: 8),
                  const Icon(Icons.keyboard_arrow_down,
                      size: 16, color: Colors.black)
                ],
              ),
            )),
      ));

  // Widget searchBar() =>
  // Container(
  //       width: 100,
  //       height: 50,
  //       decoration: BoxDecoration(
  //           border: Border.all(color: grey),
  //           borderRadius: const BorderRadius.all(Radius.circular(8))),
  //       child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Row(
  //         children: [
  //           Icon(Icons.search, size: 16, color: Colors.black,),
  //           const SizedBox(width: 8),
  //         Expanded(
  //           child: TextField(
  //             // controller: controller.searchTextController,
  //             // onChanged: (value) => controller.onChangeSearchTextField(value),
  //             style: GoogleFonts.poppins(
  //               fontSize: 14,
  //               fontWeight: FontWeight.normal,
  //               color: const Color.fromRGBO(117, 117, 117, 1.0),
  //             ),
  //             cursorColor: const Color.fromRGBO(117, 117, 117, 1.0),
  //             decoration: InputDecoration(
  //                 isDense: true,
  //                 hintText: 'Search by employee name',
  //                 hintStyle: GoogleFonts.poppins(
  //                   fontWeight: FontWeight.normal,
  //                   fontSize: 14,
  //                   color: const Color.fromRGBO(117, 117, 117, 1.0),
  //                 ),
  //                 contentPadding: EdgeInsets.zero,
  //                 border: InputBorder.none),
  //           ),
  //         ],
  //       ),),
  //     );

  Widget vaccinePlaceTable() {
    switch (controller.vaccinePlaceList.status) {
      case Status.loading:
        return const Center(
          child: LoadingIndicator(),
        );
      case Status.success:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => fadeGrey),
                  dataRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  columns: [
                    DataColumn(
                        label: Text(
                      'Aksi',
                      style: GoogleFonts.poppins(
                          color: blackGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                    DataColumn(
                        label: Text(
                      'Nama Lokasi',
                      style: GoogleFonts.poppins(
                          color: blackGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                    DataColumn(
                        label: Text(
                      'Alamat Lengkap',
                      style: GoogleFonts.poppins(
                          color: blackGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                    DataColumn(
                        label: Text(
                      'Tanggal Mulai',
                      style: GoogleFonts.poppins(
                          color: blackGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                    DataColumn(
                        label: Text(
                      'Tanggal Selesai',
                      style: GoogleFonts.poppins(
                          color: blackGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                  ],
                  rows: controller.vaccinePlaceList.data!
                      .map((item) => DataRow(cells: [
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 24,
                                  color: blue,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Colors.red,
                                )
                              ],
                            )),
                            DataCell(Text(
                              item.locationName,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14),
                            )),
                            DataCell(Text(
                              item.address,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14),
                            )),
                            DataCell(Text(
                              item.startDate.toDayMonthYearFormat,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14),
                            )),
                            DataCell(Text(
                              item.endDate.toDayMonthYearFormat,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 14),
                            )),
                          ]))
                      .toList()),
            ),
          ),
          Obx(() => controller.vaccinePlaceList.data != null &&
                  controller.vaccinePlaceList.data!.isEmpty
              ? Container(
                  color: Colors.white,
                  width: 643,
                  height: 30,
                  child: Center(
                    child: Text('No data',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: blackGrey,
                            fontSize: 14)),
                  ),
                )
              : const SizedBox())
        ]);
      case Status.error:
        return const SizedBox();
      case Status.init:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body(context));
  }
}
