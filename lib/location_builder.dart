import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navigator/permission_provider.dart';


enum _CoordinatesTitle { latitude, longitude }

class LocationBuilder extends StatefulWidget {
  const LocationBuilder({super.key});

  @override
  State<LocationBuilder> createState() => _Location();
}


class _Location extends State<LocationBuilder>  with TickerProviderStateMixin {

  ServiceStatus? _status;
  late StreamSubscription<ServiceStatus> serviceStatusStream;
  late Position? _position;
  bool _animateLatitude = true;
  bool _animateLongitude = true;



  // region Animation
  late final AnimationController _latitudeAnimationController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  late final Animation<double> _latitudeFadeAnimation = CurvedAnimation(
    parent: _latitudeAnimationController,
    curve: Curves.easeIn,
  )..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _latitudeAnimationController.stop();
      });
    }
  });


  late final AnimationController _longitudeAnimationController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  late final Animation<double> _longitudeFadeAnimation = CurvedAnimation(
    parent: _longitudeAnimationController,
    curve: Curves.easeIn,
  )..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _longitudeAnimationController.stop();
      });
    }
  });
  //endregion




  @override
  void initState() {
    super.initState();
    PermissionProvider().requestGPSPermission();
    listenToServiceStatusChange();
  }

  @override
  void dispose() {
    serviceStatusStream.cancel();
    _latitudeAnimationController.dispose();
    _longitudeAnimationController.dispose();
    super.dispose();
  }




  //region Main Widget
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
        stream: Geolocator.getPositionStream(locationSettings: const LocationSettings()),
        builder: (context, snapshot) {
          if (snapshot.data == null || !_isGPSoN()) {
            _position = null;
            return _handleLocationDataError(snapshot);
          }
          setCoordinates(snapshot);

          return Material(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(width: 5),
                          _getStyledCoordinate(_CoordinatesTitle.latitude, _animateLatitude),
                          const SizedBox(width: 25), //Space
                          _getStyledCoordinate(_CoordinatesTitle.longitude, _animateLongitude),
                          const SizedBox(width: 5)
                        ]
                    )
                  ]
              ),
            ),
          );
        }
    );
  }
//endregion



  //Private Methods
  //region Widget to display on Error
  Row _handleLocationDataError(AsyncSnapshot<Position> snapshot) {
    String msg = _status != null ? _status!.name.toUpperCase() : 'Unknown';
    MaterialColor valueColor = _isGPSoN() ? Colors.green : Colors.red;
    const TextStyle title = TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold);

    Text displayText = Text.rich(
      TextSpan(
        text: 'Location: ',
        style: title,
        children: <TextSpan>[
          TextSpan(text: msg, style: TextStyle(fontSize: 23, color: valueColor, fontWeight: FontWeight.w600)),
        ],
      ),
    );


    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          displayText,
          if (_isGPSoN()) ...[
            const SizedBox(width: 20),
            const CircularProgressIndicator(),
          ],
        ]
    );
  }
  //endregion

  //region Coordinates
  Column _getStyledCoordinate(Enum title, bool animate) {
    const TextStyle coordinatesValueStyle = TextStyle(fontSize: 35, color: Colors.blue, fontWeight: FontWeight.bold);
    TextStyle coordinatesTitleStyle = TextStyle(fontSize: 17, color: Colors.green[700], fontWeight: FontWeight.w600);
    bool isLat = title == _CoordinatesTitle.latitude;
    String coo = (isLat ? _position?.latitude : _position?.longitude)?.toStringAsFixed(6) ?? "";
    Animation<double> animation = isLat ? _latitudeFadeAnimation : _longitudeFadeAnimation;
    String titleValue = isLat ? 'Latitude' : 'Longitude';

    if (animate) {
      isLat ? _latitudeAnimationController.forward(from: 0) : _longitudeAnimationController.forward(from: 0);
    }

    return Column(
      children: <Widget>[
        Text(titleValue, style: coordinatesTitleStyle,),
        FadeTransition(
            opacity: animation,
            child: Text(coo, style: coordinatesValueStyle,)
        ),
      ],
    );
  }

  setCoordinates(AsyncSnapshot<Position> snapshot) {
    Position newPosition = snapshot.data!;
    if(_position != null) {
      _animateLatitude = _position?.latitude != newPosition.latitude;
      _animateLongitude = _position?.longitude != newPosition.longitude;
    }
    _position = newPosition;
  }
  //endregion


  Future<void> listenToServiceStatusChange() async {
    _status = await Geolocator.isLocationServiceEnabled() ? ServiceStatus.enabled : ServiceStatus.disabled;
    serviceStatusStream = Geolocator.getServiceStatusStream().listen(
            (ServiceStatus status) {
          setState(() {
            _status = status;
          });
        });
  }

  bool _isGPSoN() {
    return _status == ServiceStatus.enabled;
  }

}
