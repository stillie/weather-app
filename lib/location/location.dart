import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationRepository extends ChangeNotifier {
  final Location locationService = Location();
  double? lat;
  double? lon;
  bool hasPermissions = false;
  Future<void> init() async {
    PermissionStatus permissionStatus = await locationService.hasPermission();
    hasPermissions = permissionStatus != PermissionStatus.deniedForever &&
        permissionStatus != PermissionStatus.denied;
    if (hasPermissions) {
      final location = await locationService.getLocation();

      lat = location.latitude;
      lon = location.longitude;
    }
    notifyListeners();
  }
}
