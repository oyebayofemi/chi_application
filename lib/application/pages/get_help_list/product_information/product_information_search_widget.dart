import 'package:chi_application/application/pages/get_help_list/chi_contact_centre.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class productInformationSearchDelegate extends SearchDelegate {
  bool loggedin;
  productInformationSearchDelegate({required this.loggedin});

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                elevation: 0.0,
                backgroundColor: Color(0xff991F36),
              ),
        );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference
          .orderBy('title', descending: false)
          .snapshots()
          .asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['title']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      element['desc']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String title = data.get('title');
                final String desc = data.get('desc');
                final String descFinal = (desc.replaceAll("\\n", "\n"));
                //int index = 0;
                // print(descFinal);
                // print(title);

                return Column(
                  children: [
                    InkWell(
                      onTap: () => loggedin
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactCentre(
                                  loggedin: true,
                                ),
                              ))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactCentre(
                                  loggedin: false,
                                ),
                              )),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Text(
                            ('').toString(),
                            style: TextStyle(
                                color: Color(0xff991F36),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 18),
                          ),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                              color: Color(0xff991F36),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 16),
                        ),
                        subtitle: Text(
                          desc,
                          style: TextStyle(
                              color: Colors.grey[900],
                              //fontWeight: FontWeight.w600,
                              //fontFamily: 'Poppins',
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0.4,
                      height: 10,
                      color: Colors.grey,
                    ),
                  ],
                );
              })
            ],
          );
        } else {
          return Loading();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: collectionReference
          .orderBy('title', descending: false)
          .snapshots()
          .asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['title']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      element['desc']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String title = data.get('title');
                final String desc = data.get('desc');
                final String descFinal = (desc.replaceAll("\\n", "\n"));
                int index = 0;
                // print(descFinal);
                // print(title);

                return Column(
                  children: [
                    InkWell(
                      onTap: () => loggedin
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactCentre(
                                  loggedin: true,
                                ),
                              ))
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactCentre(
                                  loggedin: false,
                                ),
                              )),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Text(
                            ('').toString(),
                            style: TextStyle(
                                color: Color(0xff991F36),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 18),
                          ),
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                              color: Color(0xff991F36),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 16),
                        ),
                        subtitle: Text(
                          desc,
                          style: TextStyle(
                              color: Colors.grey[900],
                              //fontWeight: FontWeight.w600,
                              //fontFamily: 'Poppins',
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 0.4,
                      height: 10,
                      color: Colors.grey,
                    ),
                  ],
                );
              })
            ],
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
