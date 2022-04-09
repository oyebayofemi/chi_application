import 'package:chi_application/application/pages/get_help_list/chi_contact_centre.dart';
import 'package:chi_application/application/pages/get_help_list/product_information/product_information_search_widget.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductInformation extends StatefulWidget {
  bool loggedin;
  ProductInformation({required this.loggedin});

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
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
                  'Product Information',
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
                            delegate: productInformationSearchDelegate(
                                loggedin: widget.loggedin));
                      },
                      icon: Icon(Icons.search))
                ],
              )
            : AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'Product Information',
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
                            delegate: productInformationSearchDelegate(
                                loggedin: widget.loggedin));
                      },
                      icon: Icon(Icons.search))
                ],
              ),
        drawer: widget.loggedin ? drawers() : null,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
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
                      //print(dsnapshot.id);
                      //String uid = dsnapshot.id;
                      String desc = dsnapshot['desc'];
                      final String descFinal = (desc.replaceAll("\\n", "\n"));
                      //print(descFinal);

                      return Column(
                        children: [
                          InkWell(
                            onTap: () => widget.loggedin
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
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      color: Color(0xff991F36),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 18),
                                ),
                              ),
                              title: Text(
                                dsnapshot['title'],
                                style: TextStyle(
                                    color: Color(0xff991F36),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 16),
                              ),
                              subtitle: Text(
                                dsnapshot['desc'],
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
                    },
                  ));
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
