import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class AllMarker extends StatefulWidget {
  @override
  State<AllMarker> createState() => AllMarkerState();
}

class AllMarkerState extends State<AllMarker> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  //static dynamic data;
  String? uid;
  static double? lat;
  static double? long;
  late Map s;

  void initMarker(markerData, markerDataID) async {
    var markerID = markerDataID;
    final MarkerId markerId = MarkerId(markerID);
    final Marker marker = Marker(
      markerId: markerId,
      infoWindow: InfoWindow(title: markerData['office']),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(
          markerData['geopoint'].latitude, markerData['geopoint'].longitude),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  getData() async {
    FirebaseFirestore.instance.collection("markers").get().then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  CameraPosition initCameraPosition() {
    return CameraPosition(
      target: LatLng(9.61123120922351, 7.927301550142609),
      zoom: 5.4746,
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
          'Branch Locations (Map)',
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
        mapType: MapType.normal,
        initialCameraPosition: initCameraPosition(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
