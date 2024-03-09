import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final String streetName;
  final LatLng latLng;
  PlaceModel({
    required this.streetName,
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: "لاجتيه مول",
    latLng: const LatLng(31.21346451506027, 29.927564400000144),
    streetName: 'شارع لاجتيه',
  ),
  PlaceModel(
    id: 2,
    name: "كازينو الشاطبى",
    latLng: const LatLng(31.212109904022196, 29.915259527116255),
    streetName: 'طريق الجيش',
  ),
  PlaceModel(
    id: 3,
    name: "فندق هيلتون",
    latLng: const LatLng(31.261744185535818, 29.983453141480346),
    streetName: 'طريق الجيش',
  ),
];
