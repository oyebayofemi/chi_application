import 'package:chi_application/application/pages/screens/buy_policy/quotes_review.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PendingQuotes extends StatefulWidget {
  PendingQuotes({Key? key}) : super(key: key);

  @override
  State<PendingQuotes> createState() => _PendingQuotesState();
}

class _PendingQuotesState extends State<PendingQuotes> {
  var pendingcollections = FirebaseFirestore.instance.collection('quote');
  bool isThirdParty = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/dashboard', (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        drawer: drawers(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff991F36),
          elevation: 0,
          title: Text(
            'Pending Quotes',
            style: TextStyle(
              //color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              //fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot?>(
          stream: pendingcollections
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('pending')
              // .orderBy('time')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } else {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0 ||
                    snapshot.data!.docs.length == null) {
                  showToast('No pending quote');
                  return Container();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
                      String? title;

                      if (dsnapshot['insuredType'] == 'Corperate') {
                        title = dsnapshot['companyName'];
                      } else if (dsnapshot['insuredType'] == 'Individual') {
                        title =
                            '${dsnapshot['title']} ${dsnapshot['lastName']} ${dsnapshot['firstName']}';
                      }

                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuoteReview(
                                      isBuyPolicy: false,
                                      customerID: dsnapshot.id),
                                ));
                          },
                          child: Card(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 7,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      'https://i.stack.imgur.com/l60Hf.png'),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$title',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.email,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            dsnapshot['email'],
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            dsnapshot['phone'],
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Value of Vehicle'),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      '${dsnapshot['vehicleValue']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text('PREMIUM'),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      dsnapshot['premium'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                }
              }
              if (!snapshot.hasData) {
                return showToast('No pending quote');
              } else {
                return showToast('No pending quote');
              }
            }
          },
        ),
      ),
    );
  }
}
