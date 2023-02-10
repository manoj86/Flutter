## Navigator

![Screenshot](https://user-images.githubusercontent.com/3163167/217814389-a05091a0-7dda-44ed-8d38-4da097f832db.png)



## Navigator app shows -
	
	The direction using Gyroscope readings from the device.
	Current Location of the user using GPS.
	
## Overview

   	 The app is build in Plug and Play design.
	   (The “plug and play” architecture allows for component/class transplanting. This approach allows a functionality encapsulated in a 			      class/component to  be replaced by an alternative solution when appropriate)
   
	 App uses the device's Gyroscope to get the Heading data for the Compass and GPS for location coordinates.
   
 <br><br>
 

## Getting Started

---------
Android
---------


Added to pubspec.yaml file:

   &ensp; #flutter_compass: '^0.7.0' // Is not working well. <br>
      &emsp; So using the below version <br>
   &emsp;&emsp;   flutter_compass: <br>
   &emsp;&emsp;     git: https://github.com/hemanthrajv/flutter_compass.git <br><br>


   &ensp; flutter_icons: <br>
   &emsp;&emsp;      android: true <br>
   &emsp;&emsp;      image_path: "assets/images/compass.png" <br><br>


   &ensp; dependencies: <br>
   &emsp;&emsp; geolocator: ^8.2.0 <br>
   &emsp;&emsp; geocoding: ^2.0.4 <br>
   &emsp;&emsp; permission_handler: ^8.2.5 <br><br>

Added to AndroidManifest.xml file: <br>

&emsp;&emsp;Add either the ACCESS_FINE_LOCATION or the ACCESS_COARSE_LOCATION permission to your android/app/src/main/AndroidManifest.xml file
&emsp;&emsp;<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>

&emsp;&emsp;ACCESS_FINE_LOCATION is the most precise, whereas ACCESS_COARSE_LOCATION gives results equal to about a city block. <br>


 Asserts used
 -------------

   &ensp;  assets: <br>
   &emsp;&emsp;     - assets/images/compass.png <br>
   &emsp;&emsp;     - assets/images/here.png <br> <br>




## Imports
--------

&emsp; import 'dart:async' <br>
&emsp; import 'dart:math' as math; <br>
&emsp; import 'package:flutter/material.dart'; <br>
&emsp; import 'package:geolocator/geolocator.dart'; <br>

&emsp;&emsp; Since both the packages using same var 'PermissionStatus'. Hide one. <br>
&emsp; import 'package:location/location.dart' hide PermissionStatus; <br>
&emsp; import 'package:permission_handler/permission_handler.dart'; <br><br>







---------
## iOS
---------



Add the following lines below inside ios/Runner/Info.plist in order to access the device’s location

<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string><br>

<br>

-------------------
## Class-Diagram
-------------------
<br>
<img width="1368" alt="Class Diagram" src="https://user-images.githubusercontent.com/3163167/217630164-9af7dc9a-0f51-4e01-b500-fc63e2eb3fab.png">



