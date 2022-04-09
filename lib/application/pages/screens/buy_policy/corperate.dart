import 'dart:io';
import 'dart:math';

import 'package:chi_application/application/pages/screens/rate_calculator.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:chi_application/application/shared/loading_dialog.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:chi_application/application/shared/validate_email.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CorperateWidgetForm extends StatefulWidget {
  CorperateWidgetForm({Key? key}) : super(key: key);

  @override
  State<CorperateWidgetForm> createState() => _CorperateWidgetFormState();
}

class _CorperateWidgetFormState extends State<CorperateWidgetForm> {
  var taskcollections = FirebaseFirestore.instance.collection('customers');

  String? email, phone, companyname, customerID;
  final _formkey = GlobalKey<FormState>();
  String insuredType = 'Corperate';
  bool _isLoading = false;

  setRef(String uid) {
    Random rand = Random();
    int number = rand.nextInt(20000);

    setState(() {
      customerID = 'COPCUS$uid$number';
    });
  }

  addCustomer(String uid) async {
    await taskcollections.doc(uid).collection('customers').doc(customerID).set({
      'companyName': companyname,
      'phone': phone,
      'email': email,
      'insuredType': insuredType,
      'time': DateTime.now(),
    });

    setState(() {
      _isLoading = false;
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
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    var userData = userProvider.currentUserData;
    String firstnameValue = userData!.firstname!;
    String lastnameValue = userData.lastname!;
    String companynameValue = '$lastnameValue $firstnameValue';
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
          'Corperate',
          style: TextStyle(
            //color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            //fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: firstnameValue.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff991F36),
              ),
            )
          : Form(
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
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company Name',
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
                          initialValue: companynameValue,
                          onChanged: (value) => this.companyname = value,
                          validator: (value) => value!.isEmpty
                              ? 'Company name Field cant be empty'
                              : null,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: textFormDecoration(),
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
                          validator: (value) => value!.isEmpty
                              ? 'Phone Number Field cant be empty'
                              : null,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: textFormDecoration(),
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
                          onChanged: (value) => this.email = value,
                          validator: (value) => value!.isEmpty
                              ? 'Email Field cant be empty'
                              : validateEmail(value, context),
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration(),
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    )),
                    ButtonTheme(
                      buttonColor: Color(0xff991F36),
                      minWidth: double.infinity,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            if (companyname == null) {
                              companyname = companynameValue;
                            }
                            if (phone == null) {
                              phone = phoneValue;
                            }
                            if (email == null) {
                              email = emailValue;
                            }
                            print(companyname);
                            print(phone);
                            print(email);
                            setState(() {
                              _isLoading = true;
                              setRef(uid);
                            });

                            await addCustomer(uid);

                            showToast('Lead for $companyname created');
                          }
                        },
                        child: _isLoading
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
            ),
    );
  }
}
