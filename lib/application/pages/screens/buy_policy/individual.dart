import 'dart:math';

import 'package:chi_application/application/pages/screens/rate_calculator.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:chi_application/application/shared/validate_email.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class IndividualWidgetForm extends StatefulWidget {
  IndividualWidgetForm({Key? key}) : super(key: key);

  @override
  State<IndividualWidgetForm> createState() => _IndividualWidgetFormState();
}

class _IndividualWidgetFormState extends State<IndividualWidgetForm> {
  bool _navLoading = false;
  var taskcollections = FirebaseFirestore.instance.collection('customers');
  String? email, phone, firstname, lastname, customerID;
  final _formkey = GlobalKey<FormState>();
  String insuredType = 'Individual';

  setRef(String uid) {
    Random rand = Random();
    int number = rand.nextInt(20000);

    setState(() {
      customerID = 'INDCUS$uid$number';
    });
  }

  addCustomer(String uid) async {
    setState(() {
      _navLoading = true;
    });
    setRef(uid);
    await taskcollections.doc(uid).collection('customers').doc(customerID).set({
      'firstName': firstname,
      'lastName': lastname,
      'phone': phone,
      'email': email,
      'insuredType': insuredType,
      'time': DateTime.now(),
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RateCalculator(
            buyPolicy: true,
            customerID: customerID!,
            insuredType: insuredType,
          ),
        ));
    setState(() {
      _navLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    var userData = userProvider.currentUserData;
    String firstnameValue = userData!.firstname!;
    String lastnameValue = userData.lastname!;
    String phoneValue = userData.phone!;
    String emailValue = userData.email!;
    String uid = userData.uid!;
    return Scaffold(
      drawer: drawers(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff991F36),
        elevation: 0,
        title: Text(
          'Individual',
          style: TextStyle(
            //color: Color(0xff991F36),
            fontWeight: FontWeight.bold,
            //fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          //alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'First Name',
                style: TextStyle(
                  color: Color(0xff991F36),
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: firstnameValue,
                onChanged: (value) => this.firstname = value,
                validator: (value) =>
                    value!.isEmpty ? 'First name Field cant be empty' : null,
                keyboardType: TextInputType.text,
                decoration: textFormDecoration(),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Last Name',
                style: TextStyle(
                  color: Color(0xff991F36),
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: lastnameValue,
                onChanged: (value) => this.lastname = value,
                validator: (value) =>
                    value!.isEmpty ? 'Last Name Field cant be empty' : null,
                keyboardType: TextInputType.text,
                decoration: textFormDecoration(),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Phone Number',
                style: TextStyle(
                  color: Color(0xff991F36),
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: phoneValue,
                onChanged: (value) => this.phone = value,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) =>
                    value!.isEmpty ? 'Phone Number Field cant be empty' : null,
                keyboardType: TextInputType.number,
                decoration: textFormDecoration(),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Email Address',
                style: TextStyle(
                  color: Color(0xff991F36),
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: emailValue,
                // style: TextStyle(
                //   color: Colors.grey,
                //   fontFamily: 'Poppins',
                // ),
                onChanged: (value) => this.email = value,
                validator: (value) => value!.isEmpty
                    ? 'Email Field cant be empty'
                    : validateEmail(value, context),
                keyboardType: TextInputType.emailAddress,
                decoration: textFormDecoration(),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 200,
              ),
              ButtonTheme(
                buttonColor: Color(0xff991F36),
                minWidth: double.infinity,
                height: 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      if (firstname == null) {
                        firstname = firstnameValue;
                      }
                      if (lastname == null) {
                        lastname = lastnameValue;
                      }
                      if (phone == null) {
                        phone = phoneValue;
                      }
                      if (email == null) {
                        email = emailValue;
                      }
                      await addCustomer(uid);
                      showToast('Lead for $lastname created');

                      // print(firstname);
                      // print(lastname);
                      // print(phone);
                      // print(email);
                    }
                  },
                  child: _navLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Create Customer',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
