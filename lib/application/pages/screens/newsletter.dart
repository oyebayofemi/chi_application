import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Newsletter extends StatefulWidget {
  const Newsletter({Key? key}) : super(key: key);

  @override
  State<Newsletter> createState() => _NewsletterState();
}

class _NewsletterState extends State<Newsletter> {
  bool? _isChecked = false;
  String? uid;

  getInfo() async {
    var values = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    setState(() {
      _isChecked = values.get('isChecked');
      uid = values.get('uid');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
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
          'Change Password',
          style: TextStyle(
            //color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            //fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: uid == null
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff991F36),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: Colors.pink,
                          title: Text(
                            "Subscribe to our Newslwtters?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          value: _isChecked,
                          onChanged: (newValue) {
                            setState(() {
                              _isChecked = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ],
                    ),
                  ),
                  ButtonTheme(
                    buttonColor: Color(0xff991F36),
                    minWidth: double.infinity,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: RaisedButton(
                      onPressed: () async {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .update({
                          'isChecked': _isChecked,
                        });
                        showToast('Newsletter Signup updated successfully');
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Update',
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
    );
  }
}
