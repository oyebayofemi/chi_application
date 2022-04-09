import 'package:chi_application/application/pages/authentication/login_page.dart';
import 'package:chi_application/application/pages/authentication/regsiter/register_confirm_email_verfication.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:chi_application/application/shared/loading_dialog.dart';
import 'package:chi_application/application/shared/snackbar.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:chi_application/application/shared/validate_email.dart';
import 'package:chi_application/auth.config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

class RegisterWithEmail extends StatefulWidget {
  RegisterWithEmail({Key? key}) : super(key: key);

  @override
  State<RegisterWithEmail> createState() => _RegisterWithEmailState();
}

class _RegisterWithEmailState extends State<RegisterWithEmail> {
  final formkey = GlobalKey<FormState>();
  String? email;
  //int count = 0;
  late EmailAuth emailAuth;
  bool isloading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailAuth = new EmailAuth(sessionName: "Test Session");
    emailAuth.config(remoteServerConfiguration);
  }

  sendOTP(String email) async {
    setState(() {
      isloading = true;
    });
    if (await emailAuth.config(remoteServerConfiguration)) {
      var res = await emailAuth.sendOtp(recipientMail: email, otpLength: 6);
      if (res) {
        print("Verification Code Sent!");
        setState(() {
          isloading = false;
        });
        showSnackBar(context, 'Verification Code Sent!');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmEmailVerficaionCode(email),
            ));
      } else {
        setState(() {
          isloading = false;
        });
        print("Failed to send the verification code");
        showSnackBar(context, 'Failed to send the verification code');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              ModalRoute.withName("/login")),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff991F36),
        elevation: 0,
        title: Text(
          'Customer Registration',
          style: TextStyle(
            //color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            //fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(25),
          height: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please enter a valid Email Address',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xff991F36),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Spacer(),
              TextFormField(
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
                onChanged: (value) => this.email = value,
                validator: (value) => value!.isEmpty
                    ? 'Email Field cant be empty'
                    : validateEmail(value, context),
                keyboardType: TextInputType.emailAddress,
                decoration:
                    textFormDecoration().copyWith(hintText: 'Email address'),
              ),
              Spacer(),
              ButtonTheme(
                buttonColor: Color(0xff991F36),
                minWidth: double.infinity,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: RaisedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      String? texts;
                      try {
                        setState(() {
                          isloading = true;
                        });
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("users")
                            .where("email", isEqualTo: email)
                            .get();
                        texts = snap.docs[0]['email'];

                        if (texts != null) {
                          setState(() {
                            isloading = false;
                          });
                          showToast('Email already exists');
                        } else {}
                      } catch (e) {
                        print(e);
                        // showSnackBar(
                        //     context, 'Enter a valid Username');
                        setState(() {
                          isloading = false;
                        });

                        await sendOTP(email!);
                      }
                    }
                  },
                  child: isloading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'NEXT',
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
