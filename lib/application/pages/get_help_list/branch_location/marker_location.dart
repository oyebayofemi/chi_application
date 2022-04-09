import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';

class MarkerLocation extends StatefulWidget {
  MarkerLocation(this.uid, this.office, this.lattitude, this.longitude);
  late String uid;
  late String office;
  late double lattitude;
  late double longitude;

  @override
  State<MarkerLocation> createState() => MarkerLocationState();
}

class MarkerLocationState extends State<MarkerLocation> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> customMarkers = [];

  //static dynamic data;
  String? uid;
  static String? off;
  static double? lat;
  static double? long;
  late DocumentSnapshot snapshot;

  void initState() {
    super.initState();
    off = widget.office;
    lat = widget.lattitude;
    long = widget.longitude;
  }

  CameraPosition initCameraPosition() {
    double la = lat!;
    print(la);
    double lo = long!;
    print(lo);
    return CameraPosition(
      target: LatLng(la, lo),
      zoom: 12.4746,
    );
  }

  Marker initMarker() {
    double la = lat!;
    print(la);
    double lo = long!;
    print(lo);
    return Marker(
      markerId: MarkerId('_k$off Marker'),
      // ignore: unnecessary_string_interpolations
      infoWindow: InfoWindow(title: '$off'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(la, lo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xff991F36),
        elevation: 0,
        title: Text(
          'Google Map',
          style: TextStyle(
            //color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            //fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: GoogleMap(
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          tiltGesturesEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: initCameraPosition(),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {initMarker.call()},
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
            ),
          ].toSet()),
    );
  }
}
