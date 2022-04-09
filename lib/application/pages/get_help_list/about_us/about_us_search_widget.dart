import 'package:chi_application/application/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class aboutUSSearchDelegate extends SearchDelegate {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('aboutUS');

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
                print(descFinal);
                print(title);

                return ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                        color: Color(0xff991F36),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        descFinal,
                        style: TextStyle(
                            color: Colors.grey[900],
                            //fontWeight: FontWeight.w600,
                            //fontFamily: 'Poppins',
                            fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                      Divider(
                        thickness: 0.4,
                        height: 10,
                        color: Colors.grey,
                      ),
                    ],
                  ),
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
                print(descFinal);
                print(title);

                return ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                        color: Color(0xff991F36),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          descFinal,
                          style: TextStyle(
                              color: Colors.grey[900],
                              //fontWeight: FontWeight.w600,
                              //fontFamily: 'Poppins',
                              fontSize: 15),
                          textAlign: TextAlign.justify,
                        ),
                        Divider(
                          thickness: 0.4,
                          height: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
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
