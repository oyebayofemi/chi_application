import 'package:chi_application/application/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class frequentlyAskedQuestionsSearchDelegate extends SearchDelegate {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('questions');

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
          .orderBy('id', descending: false)
          .snapshots()
          .asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['question']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      element['answer']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String question = data.get('question');
                final String ans = data.get('answer');
                final String ansFinal = (ans.replaceAll("\\n", "\n"));
                // print(descFinal);
                // print(title);

                return Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.grey, // here for close state
                    colorScheme: ColorScheme.light(
                      primary: Colors.white,
                    ), // here for open state in replacement of deprecated accentColor
                    // dividerColor: Colors
                    //     .transparent, // if you want to remove the border
                  ),
                  child: ExpansionTile(
                    title: Text(
                      question,
                      style: TextStyle(
                          color: Color(0xff991F36),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 18),
                    ),
                    controlAffinity: ListTileControlAffinity.platform,
                    iconColor: Colors.grey,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 5, 15),
                        child: Text(ansFinal),
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
          .orderBy('id', descending: false)
          .snapshots()
          .asBroadcastStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              ...snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) =>
                      element['question']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      element['answer']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                  .map((QueryDocumentSnapshot<Object?> data) {
                final String question = data.get('question');
                final String ans = data.get('answer');
                final String ansFinal = (ans.replaceAll("\\n", "\n"));
                // print(descFinal);
                // print(title);

                return Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.grey, // here for close state
                    colorScheme: ColorScheme.light(
                      primary: Colors.white,
                    ), // here for open state in replacement of deprecated accentColor
                    // dividerColor: Colors
                    //     .transparent, // if you want to remove the border
                  ),
                  child: ExpansionTile(
                    title: Text(
                      question,
                      style: TextStyle(
                          color: Color(0xff991F36),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 18),
                    ),
                    controlAffinity: ListTileControlAffinity.platform,
                    iconColor: Colors.grey,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 5, 15),
                        child: Text(ansFinal),
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
}
