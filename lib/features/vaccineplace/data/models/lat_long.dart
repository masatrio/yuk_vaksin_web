class LatLong {
  final double latitude;
  final double longitude;

  factory LatLong.fromJson(Map<String, dynamic> json) =>
      LatLong(latitude: json['lat'], longitude: json['lng']);

  LatLong({required this.latitude, required this.longitude});
}
