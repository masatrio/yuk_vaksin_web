class VaccinePlace {
  final int id;
  final String locationName;
  final String address;
  final String startDate;
  final String endDate;

  VaccinePlace(
      {required this.id,
      required this.locationName,
      required this.address,
      required this.startDate,
      required this.endDate});

  factory VaccinePlace.fromJson(Map<String, dynamic> json) => VaccinePlace(
      id: json['id'],
      locationName: json['locationName'],
      address: json['address'],
      startDate: json['startDate'],
      endDate: json['endDate']);
}
