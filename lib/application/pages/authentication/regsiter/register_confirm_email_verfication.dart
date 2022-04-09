import 'package:chi_application/application/pages/authentication/login_page.dart';
import 'package:chi_application/application/pages/authentication/regsiter/customer_registration_data_form.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:chi_application/application/shared/loading_dialog.dart';
import 'package:chi_application/application/shared/snackbar.dart';
import 'package:chi_application/application/shared/validate_email.dart';
import 'package:chi_application/auth.config.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

class ConfirmEmailVerficaionCode extends StatefulWidget {
  late String em;
  ConfirmEmailVerficaionCode(this.em);

  @override
  State<ConfirmEmailVerficaionCode> createState() =>
      _ConfirmEmailVerficaionCodeState();
}

class _ConfirmEmailVerficaionCodeState
    extends State<ConfirmEmailVerficaionCode> {
  final formkey = GlobalKey<FormState>();
  String? code;
  String? email;
  //int count = 0;
  bool isloading = false;
  late EmailAuth emailAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.em;
    emailAuth = new EmailAuth(sessionName: "Test Session");
    emailAuth.config(remoteServerConfiguration);
  }

  verifyOTP(String email, String otp) async {
    setState(() {
      isloading = true;
    });
    if (await emailAuth.config(remoteServerConfiguration)) {
      var res = emailAuth.validateOtp(recipientMail: email, userOtp: otp);
      if (res) {
        print("Email Verified!");
        showSnackBar(context, 'Email Verified!');
        setState(() {
          isloading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerRegistrationForm(email),
            ));
      } else {
        setState(() {
          isloading = false;
        });
        print("Invalid Verification Code");
        showSnackBar(context, 'Invalid Verification Code');
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
                'Please enter the verification code sent to your email address',
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
                onChanged: (value) => this.code = value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value!.isEmpty ? 'Code Field cant be empty' : null,
                keyboardType: TextInputType.number,
                decoration: textFormDecoration()
                    .copyWith(hintText: 'Verification Code'),
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
                      await verifyOTP(email!, code!);
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
