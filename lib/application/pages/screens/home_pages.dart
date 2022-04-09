import 'package:chi_application/application/pages/screens/my_policies.dart';
import 'package:chi_application/application/pages/screens/pending_quotes.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? pendingCount;
  int? policyCount;
  DateTime timeBackPressed = DateTime.now();

  Stream<int> getPendingCount() {
    return FirebaseFirestore.instance
        .collection('quote')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('pending')
        .snapshots()
        .map((documentSnapshot) => documentSnapshot.docs.length);
  }

  Stream<int> getPolicyCount() {
    return FirebaseFirestore.instance
        .collection('policy')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('policy')
        .snapshots()
        .map((documentSnapshot) => documentSnapshot.docs.length);
  }

  @override
  void initState() {
    super.initState();
    getPendingCount();
  }

  final List<MenuData> menu = [
    MenuData(Icons.stars_outlined, 'No. of Policies'),
    MenuData(FontAwesomeIcons.newspaper, 'Pending Quotes'),
    MenuData(Icons.account_circle_rounded, 'About to Expire'),
    MenuData(Icons.https_outlined, 'Expired'),
    MenuData(FontAwesomeIcons.carCrash, 'Total Claims')
  ];
  int k = 0;

  @override
  Widget build(BuildContext context) {
    getPendingCount().listen((activityCount) {
      if (mounted) {
        setState(() {
          pendingCount = activityCount;
        });
      }
    });

    getPolicyCount().listen((activityCount) {
      if (mounted) {
        setState(() {
          policyCount = activityCount;
        });
      }
    });

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(
              msg: message, fontSize: 15, gravity: ToastGravity.BOTTOM);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        drawer: drawers(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff991F36),
          elevation: 0,
          title: Text(
            'Dashboard',
            style: TextStyle(
              //color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              //fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ),
        body: pendingCount == null
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xff991F36),
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: GridView.builder(
                    itemCount: menu.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (menu[index].title == 'Pending Quotes') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PendingQuotes(),
                                ));
                          }
                          if (menu[index].title == 'No. of Policies') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyPolicy(),
                                ));
                          }
                        },
                        child: Container(
                          height: 200,
                          child: Card(
                            semanticContainer: true,
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Icon(
                                    menu[index].icon,
                                    size: 50,
                                    color: Colors.grey[800],
                                  ),
                                  SizedBox(height: 30),
                                  if (menu[index].title == 'No. of Policies')
                                    Container(
                                      height: 20,
                                      child: Text('$policyCount'),
                                    ),
                                  if (menu[index].title == 'Pending Quotes')
                                    Container(
                                      height: 20,
                                      child: Text('$pendingCount'),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(menu[index].title),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}

class MenuData {
  MenuData(this.icon, this.title);
  final IconData icon;
  final String title;
}
