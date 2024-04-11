import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationRepository extends ChangeNotifier {
  double? lat;
  double? lon;
  bool hasPermissions = false;
  final Location locationService = Location.instance;

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  late LocationData _locationData;
  Future<LocationData?> initLocationData() async {
    // This is terrible! There is a known bug that crashes the app because the android system for location has not been enabled by the time it gets here
    // Note: This only happened when running the app in release mode (-_-)
    // See: https://stackoverflow.com/questions/67663357/flutter-location-package-generates-platform-exception-on-call-to-serviceenabled

    try {
      _serviceEnabled = await locationService.serviceEnabled();
    } on PlatformException catch (err) {
      print("Platform exception calling serviceEnabled(): $err");
      _serviceEnabled = false;

      // location service is still not created
      initLocationData(); // re-invoke himself every time the error is catch, so until the location service setup is complete
    }
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    hasPermissions = true;
    _locationData = await locationService.getLocation();
    notifyListeners();
    return _locationData;
  }
}
