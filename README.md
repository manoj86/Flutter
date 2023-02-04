# Navigator

App to show -
	
	The direction using Gyroscope readings from the device.
	Current Location of the user.

## Getting Started

---------
Android
---------


Add to pubspec.yaml file.

 #flutter_compass: '^0.7.0' // Is not working well. So using the below version
  flutter_compass:
    git: https://github.com/hemanthrajv/flutter_compass.git



flutter_icons:
    android: true
    image_path: "assets/images/compass.png"



Imports
flutter pub add geolocator
flutter pub add geocoding

or

dependencies:
  geolocator: ^8.2.0
  geocoding: ^2.0.4


permission_handler: ^8.2.5


 Asserts used

 assets:
    - assets/images/compass.png
    - assets/images/here.png



Add either the ACCESS_FINE_LOCATION or the ACCESS_COARSE_LOCATION permission your android/app/src/main/AndroidManifest.xml file

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
ACCESS_FINE_LOCATION is the most precise, whereas ACCESS_COARSE_LOCATION gives results equal to about a city block.


Imports
--------


import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';





---------
iOS
---------



Add the following lines below inside ios/Runner/Info.plist in order to access the device’s location

<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>


