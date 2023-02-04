import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassBuilder extends StatefulWidget {
  const CompassBuilder({super.key});

  @override
  State<CompassBuilder> createState() => _Compass();
}


class _Compass extends State<CompassBuilder> {
  @override
  void initState() {
    super.initState();
  }

  double _direction = 0; // To save the heading value

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        double? tempDirection = snapshot.data!.heading;

        if (tempDirection == null) { // if the device does not support sensor.
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        _direction = tempDirection;

        return Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _getHeadingWithCardinal(_direction),
              _getCurrentPositionImage(),
              _getCompass(),
            ],
          ),
        );
      },
    );
  }



  //Private Methods

  Image _getCurrentPositionImage() {
    const currentPositionImage = 'assets/images/here.png';
    return Image.asset(currentPositionImage, height: 125, width: 80);
  }

  Container _getCompass() {
    String compassImage = 'assets/images/compass.png';
    return Container(
      transform: Matrix4.translationValues(0.0, -27.5, 0.0),
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Transform.rotate(
        angle: (_direction * (math.pi / 180) * -1),
        child: Image.asset(compassImage),
      ),
    );
  }


  Container _getHeadingWithCardinal(double heading) {
    int roundedDirectionValue = heading.round();
    return Container(
      transform: Matrix4.translationValues(0.0, 15, 0.0),
      child:
      Text.rich(
        TextSpan(
          text: '$roundedDirectionValue\u00B0',
          style: const TextStyle(fontSize: 55),
          children: <TextSpan>[
            TextSpan(text: _cardinalDirection(roundedDirectionValue), style: const TextStyle(fontSize: 35, color: Colors.red)),
          ],
        ),
      ),
    );
  }

  String _cardinalDirection(int direction) {
    String cardinalDirection = "";

    if (direction > 23 && direction <= 67) {
      cardinalDirection = "NE";
    } else if (direction > 68 && direction <= 112) {
      cardinalDirection = "E";
    } else if (direction > 113 && direction <= 167) {
      cardinalDirection = "SE";
    } else if (direction > 168 && direction <= 202) {
      cardinalDirection = "S";
    } else if (direction > 203 && direction <= 247) {
      cardinalDirection = "SW";
    } else if (direction > 248 && direction <= 293) {
      cardinalDirection = "W";
    } else if (direction > 294 && direction <= 337) {
      cardinalDirection = "NW";
    } else if (direction >= 338 || direction <= 22) {
      cardinalDirection = "N";
    }
    return cardinalDirection;
  }
}
