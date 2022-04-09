import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPolicy extends StatefulWidget {
  MyPolicy({Key? key}) : super(key: key);

  @override
  State<MyPolicy> createState() => _MyPolicyState();
}

class _MyPolicyState extends State<MyPolicy> {
  var pendingcollections = FirebaseFirestore.instance.collection('policy');
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
              'Policies',
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
                .collection('policy')
                // .orderBy('time')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loading();
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length == 0 ||
                      snapshot.data!.docs.length == null) {
                    showToast('You have no Policies.');
                    return Container();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
                        String? title;

                        // if (dsnapshot['insuredType'] == 'Corperate') {
                        //   title = dsnapshot['companyName'];
                        // } else if (dsnapshot['insuredType'] == 'Individual') {
                        //   title =
                        //       '${dsnapshot['title']} ${dsnapshot['lastName']} ${dsnapshot['firstName']}';
                        // }

                        return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => QuoteReview(
                              //           isBuyPolicy: false,
                              //           customerID: dsnapshot.id),
                              //     ));
                            },
                            child: Card(
                              child: Row(
                                children: [],
                              ),
                            ));
                      },
                    );
                  }
                }
                if (!snapshot.hasData) {
                  return showToast('You have no Policies.');
                } else {
                  return showToast('You have no Policies.');
                }
              }
            },
          ),
        ));
  }
}
