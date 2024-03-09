import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> checkAndRequestLocationService() async {
    var isEnableLocationService = await location.serviceEnabled();
    if (!isEnableLocationService) {
      isEnableLocationService = await location.requestService();
      if (!isEnableLocationService) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }
    return true;
  }

  void getRealTimeLocationData({required  void Function(LocationData)? onData,})async
  {
    location.changeSettings(
      distanceFilter:2.0,
    );
    location.onLocationChanged.listen(onData);
  }
}
