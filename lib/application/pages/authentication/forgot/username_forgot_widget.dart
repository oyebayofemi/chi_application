import 'package:chi_application/application/pages/authentication/login_page.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:flutter/material.dart';

class UsernameForgot extends StatefulWidget {
  UsernameForgot({Key? key}) : super(key: key);

  @override
  State<UsernameForgot> createState() => _UsernameForgotState();
}

class _UsernameForgotState extends State<UsernameForgot> {
  final formkey = GlobalKey<FormState>();
  String? username;
  int count = 0;
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
          'Forgot Password',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please enter Username',
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
                onChanged: (value) => this.username = value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value!.isEmpty ? 'Username Field cant be empty' : null,
                keyboardType: TextInputType.text,
                decoration: textFormDecoration().copyWith(hintText: 'Username'),
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
                      print('sent ');
                    }
                  },
                  child: Text(
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
