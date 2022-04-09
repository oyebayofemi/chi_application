import 'package:chi_application/application/pages/screens/buy_policy/corperate_customer_information.dart';
import 'package:chi_application/application/pages/screens/buy_policy/comprehensive_vehicle_information_individual.dart';
import 'package:chi_application/application/pages/screens/buy_policy/individual_customer_information.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerInformationTypeWidget extends StatefulWidget {
  String customerID;
  CustomerInformationTypeWidget({required this.customerID});

  @override
  State<CustomerInformationTypeWidget> createState() =>
      _CustomerInformationTypeWidgetState();
}

class _CustomerInformationTypeWidgetState
    extends State<CustomerInformationTypeWidget> {
  var taskcollections = FirebaseFirestore.instance.collection('customers');
  String? insuredType;

  getinfo() async {
    var value = await taskcollections
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('customers')
        .doc(widget.customerID)
        .get();

    setState(() {
      insuredType = value.get('insuredType');
    });
  }

  @override
  void initState() {
    super.initState();
    getinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawers(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff991F36),
        elevation: 0,
        title: Text(
          'Buy Policy',
          style: TextStyle(
            //color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            //fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: insuredType == null
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff991F36),
              ),
            )
          : insuredType == 'Individual'
              ? CustomerInformationIndividual(
                  customerID: widget.customerID,
                )
              : CustomerInformationCorperate(customerID: widget.customerID),
    );
  }
}
