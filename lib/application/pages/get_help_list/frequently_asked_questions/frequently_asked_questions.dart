import 'package:chi_application/application/pages/get_help_list/frequently_asked_questions/frequently_asked_question_search_widget.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FrequentlyAskedQuestions extends StatefulWidget {
  bool loggedin;
  FrequentlyAskedQuestions({required this.loggedin});

  @override
  State<FrequentlyAskedQuestions> createState() =>
      _FrequentlyAskedQuestionsState();
}

class _FrequentlyAskedQuestionsState extends State<FrequentlyAskedQuestions> {
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
                  'Frequently Asked Questions',
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
                            delegate: frequentlyAskedQuestionsSearchDelegate());
                      },
                      icon: Icon(Icons.search))
                ],
              )
            : AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'Frequently Asked Questions',
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
                            delegate: frequentlyAskedQuestionsSearchDelegate());
                      },
                      icon: Icon(Icons.search))
                ],
              ),
        drawer: widget.loggedin ? drawers() : null,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('questions')
              .orderBy('id', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
                    //print(dsnapshot.id);
                    //String uid = dsnapshot.id;
                    String desc = dsnapshot['answer'];
                    final String descFinal = (desc.replaceAll("\\n", "\n"));
                    //print(descFinal);

                    return Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor:
                            Colors.grey, // here for close state
                        colorScheme: ColorScheme.light(
                          primary: Colors.white,
                        ), // here for open state in replacement of deprecated accentColor
                        // dividerColor: Colors
                        //     .transparent, // if you want to remove the border
                      ),
                      child: ExpansionTile(
                        title: Text(
                          dsnapshot['question'],
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
                            child: Text(
                              descFinal,
                              style: TextStyle(
                                //color: Colors.grey[900],
                                //fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                //fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
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
