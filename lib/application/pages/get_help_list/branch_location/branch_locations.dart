import 'package:chi_application/application/pages/get_help_list/branch_location/all_marker.dart';
import 'package:chi_application/application/pages/get_help_list/branch_location/marker_location.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BranchLocations extends StatefulWidget {
  bool loggedin;
  BranchLocations({required this.loggedin});

  @override
  State<BranchLocations> createState() => _BranchLocationsState();
}

class _BranchLocationsState extends State<BranchLocations> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.loggedin) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboard', (Route<dynamic> route) => false);
          return false;
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst);
          return false;
        }
      },
      child: Scaffold(
        appBar: widget.loggedin
            ? AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'Branch Locations',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                actions: [
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllMarker(),
                            ));
                      }
                    },
                    icon: Icon(Icons.more_vert_rounded),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text('Map View'),
                      ),
                    ],
                  ),
                ],
              )
            : AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'Branch Locations',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                actions: [
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllMarker(),
                            ));
                      }
                    },
                    icon: Icon(Icons.more_vert_rounded),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text('Map View'),
                      ),
                    ],
                  ),
                ],
              ),
        drawer: widget.loggedin ? drawers() : null,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('markers')
              .orderBy('office', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
                  //print(dsnapshot.id);
                  String uid = dsnapshot.id;
                  String address = dsnapshot['address'];
                  final String addressFinal = (address.replaceAll("\\n", "\n"));
                  String tel = dsnapshot['tel'];
                  final String telFinal = (tel.replaceAll("\\n", "\n"));
                  String email = dsnapshot['email'];
                  final String emailFinal = (email.replaceAll("\\n", "\n"));
                  //int k = 1;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarkerLocation(
                                  uid,
                                  dsnapshot['office'],
                                  dsnapshot['geopoint'].latitude,
                                  dsnapshot['geopoint'].longitude)));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  color: Color(0xff991F36),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 18),
                            ),
                          ),
                          title: Text(
                            dsnapshot['office'],
                            style: TextStyle(
                                color: Color(0xff991F36),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 16),
                          ),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$addressFinal',
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      //fontWeight: FontWeight.w600,
                                      //fontFamily: 'Poppins',
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Tel: $telFinal',
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      //fontWeight: FontWeight.w600,
                                      //fontFamily: 'Poppins',
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Email: $emailFinal',
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      //fontWeight: FontWeight.w600,
                                      //fontFamily: 'Poppins',
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                              ]),
                        ),
                        Divider(
                          thickness: 0.4,
                          height: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
