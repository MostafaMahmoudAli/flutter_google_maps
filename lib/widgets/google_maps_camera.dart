import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_maps/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? _googleMapController;
  late LocationService _locationService;
  Set<Marker> markers = {};
  bool isFirstCall = true;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        31.237598751717545,
        29.95694032567295,
      ),
      zoom: 15.0,
    );
    _locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            markers: markers,
            onMapCreated: (controller) {
              _googleMapController = controller;
              setMapStyle();
            },
            initialCameraPosition: initialCameraPosition,
          ),
        ],
      ),
    );
  }

  void setMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/night_map.json");
    _googleMapController!.setMapStyle(nightMapStyle);
  }

  Future<Uint8List> getImageFromRowData({
    required String image,
    required double width,
  }) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );
    var imageFrameInfo = await imageCodec.getNextFrame();
    var imageByteData =
        await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return imageByteData!.buffer.asUint8List();
  }

  void updateMyLocation() async {
    await _locationService.checkAndRequestLocationService();
    var servicePermission =
        await _locationService.checkAndRequestLocationPermission();
    if (servicePermission) {
      _locationService.getRealTimeLocationData(onData: (locationData) {
        updateMyCamera(locationData);
        setMyLocationMarker(locationData);
      });
    }
  }

  void updateMyCamera(LocationData locationData) {
    if (isFirstCall) {
      var cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 17,
      );
      _googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } else {
      _googleMapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(locationData.latitude!, locationData.longitude!),
      ));
    }
  }

  void setMyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
      markerId: const MarkerId("my_locaton_marker"),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );
    markers.add(myLocationMarker);
    setState(() {});
  }
}