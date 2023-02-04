import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:navigator/permission_provider.dart';



class LocationBuilder extends StatefulWidget {
  const LocationBuilder({super.key});

  @override
  State<LocationBuilder> createState() => _Location();
}


class _Location extends State<LocationBuilder> {

  ServiceStatus? _status;
  Position? _currentPosition;
  late StreamSubscription<ServiceStatus> serviceStatusStream;


  @override
  void initState() {
    super.initState();
    PermissionProvider().requestGPSPermission();
    listenToRequest();
  }

  @override
  void dispose() {
    serviceStatusStream.cancel();
    super.dispose();
  }

  Future<void> listenToRequest() async {
    _status = await Geolocator.isLocationServiceEnabled() ? ServiceStatus.enabled : ServiceStatus.disabled;
    serviceStatusStream = Geolocator.getServiceStatusStream().listen(
            (ServiceStatus status) {
              setState(() {
                _status = status;
              });
            });
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Position>(
        stream: Geolocator.getPositionStream(locationSettings: const LocationSettings()),
        builder: (context, snapshot) {
          if (snapshot.data == null) { return _handleError(snapshot); }

          _currentPosition = snapshot.data!;

          return Material(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _getStyledCoordinate('Latitude', _currentPosition!.latitude),
                          const SizedBox(width: 45), //Space
                          _getStyledCoordinate('Longitude', _currentPosition!.longitude)
                        ]
                    )
                  ]
              ),
            ),
          );
        }
    );
  }


  //Private Methods
  Row _handleError(AsyncSnapshot<Position> snapshot) {
    String msg = _status != null ? _status!.name.toUpperCase() : 'Loading....';
    MaterialColor valueColor = _status == ServiceStatus.enabled ? Colors.green : Colors.red;
    const TextStyle title = TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold);

    Text displayText = Text.rich(
      TextSpan(
        text: 'Location : ',
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
          if (_status != ServiceStatus.disabled) ...[
            const SizedBox(width: 20),
            const CircularProgressIndicator(),
          ],
        ]
    );
  }


  Column _getStyledCoordinate(String title, double coo) {
    const TextStyle coordinatesValueStyle = TextStyle(fontSize: 32, color: Colors.blue, fontWeight: FontWeight.bold);
    const TextStyle coordinatesTitleStyle = TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.w600);

    return Column(
          children: <Widget>[
            Text(title, style: coordinatesTitleStyle,),
            Text(coo.toStringAsFixed(5), style: coordinatesValueStyle,)
          ],
        );
  }

}
