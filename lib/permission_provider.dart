import 'package:location/location.dart' hide PermissionStatus ; // Since both the packages using same var 'PermissionStatus'. Hide one.
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider {
  void requestGPSPermission() {
    _requestPermission();
  }

  void _requestPermission() async {
    var location = Location();

    Future<void> requestEnableGPS() async {
      if (!await Permission.location.isGranted) {
        await [Permission.locationWhenInUse, Permission.locationAlways].request();
        location.requestService();
      } else if (!await Permission.location.serviceStatus.isDisabled) {
        location.requestService();
      }
    }
    requestEnableGPS();
  }

}