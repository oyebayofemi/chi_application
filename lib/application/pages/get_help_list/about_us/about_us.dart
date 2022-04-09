import 'package:chi_application/application/pages/get_help_list/about_us/about_us_search_widget.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AboutUS extends StatefulWidget {
  bool loggedin;
  AboutUS({required this.loggedin});

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
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
                  'About Us',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: aboutUSSearchDelegate());
                      },
                      icon: Icon(Icons.search))
                ],
              )
            : AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'About Us',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: aboutUSSearchDelegate());
                      },
                      icon: Icon(Icons.search))
                ],
              ),
        drawer: widget.loggedin ? drawers() : null,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('aboutUS')
              .orderBy('title', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
                    print(dsnapshot.id);
                    //String uid = dsnapshot.id;
                    String desc = dsnapshot['desc'];
                    final String descFinal = (desc.replaceAll("\\n", "\n"));
                    //print(descFinal);

                    return Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dsnapshot['title'],
                              style: TextStyle(
                                  color: Color(0xff991F36),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                descFinal,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    //fontWeight: FontWeight.w600,
                                    //fontFamily: 'Poppins',
                                    fontSize: 15),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Divider(
                              thickness: 0.4,
                              height: 10,
                              color: Colors.grey,
                            ),
                          ]),
                    );
                  },
                ),
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
