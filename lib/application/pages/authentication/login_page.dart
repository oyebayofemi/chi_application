import 'package:chi_application/application/pages/authentication/regsiter/register_dialog.dart';
import 'package:chi_application/application/pages/authentication/regsiter/register_with_email.dart';
import 'package:chi_application/application/pages/get_help.dart';
import 'package:chi_application/application/services/AuthServiceController.dart';
import 'package:chi_application/application/shared/forgot_username_email_password_dialog.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:chi_application/application/shared/loading_dialog.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:chi_application/application/shared/validate_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  String? email, password;
  bool _loading = false;

  //To check fields during submit
  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    child: Image.asset('assets/chi full.jpg'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer Login',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xff991F36),
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Continue to Sign In!',
                          style: TextStyle(
                            //color: Color(0xff991F36),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                          onChanged: (value) => this.email = value,
                          //autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value!.isEmpty
                              ? 'Username/Email Field cant be empty'
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration()
                              .copyWith(hintText: 'Username/Email'),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (value) => this.password = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          validator: (value) => value!.isEmpty
                              ? 'Password Field cant be empty'
                              : null,
                          keyboardType: TextInputType.number,
                          decoration: textFormDecoration()
                              .copyWith(hintText: 'Password'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          buttonColor: Color(0xff991F36),
                          minWidth: double.infinity,
                          height: 60,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: RaisedButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  _loading = true;
                                });
                                String? texts;
                                RegExp regex = RegExp(r'@');
                                if (regex.hasMatch(email!)) {
                                  print(email);
                                  texts = email;

                                  try {
                                    await AuthController().signin(
                                        context: context,
                                        email: texts!,
                                        password: password!);

                                    setState(() {
                                      _loading = false;
                                    });
                                  } catch (e) {
                                    print(e);
                                    setState(() {
                                      _loading = false;
                                    });
                                    // showSnackBar(
                                    //     context, 'Enter a valid Username');
                                    showToast(e.toString());
                                  }
                                } else {
                                  try {
                                    QuerySnapshot snap = await FirebaseFirestore
                                        .instance
                                        .collection("users")
                                        .where("username", isEqualTo: email)
                                        .get();
                                    texts = snap.docs[0]['email'];
                                    await AuthController().signin(
                                        context: context,
                                        email: texts!,
                                        password: password!);

                                    setState(() {
                                      _loading = false;
                                    });
                                  } catch (e) {
                                    print(e);
                                    setState(() {
                                      _loading = false;
                                    });
                                    // showSnackBar(
                                    //     context, 'Enter a valid Username');
                                    showToast('Enter a valid Username');
                                  }
                                  print('$texts');
                                }
                              }
                            },
                            child: _loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ForgotUsernameEmailPasswordDialog();
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 2),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Username/Email/Password?',
                              style: TextStyle(
                                  color: Color(0xff991F36),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                  fontSize: 15),
                              //textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GetHelp(),
                                    ));
                              },
                              child: Text(
                                'Get Help',
                                style: TextStyle(
                                    color: Color(0xff991F36),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2),
                              ),
                            ),
                            Expanded(child: Text('')),
                            Text(
                              'Dont have an account?',
                              style: TextStyle(
                                  color: Color(0xff991F36),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 13),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return RegisterDialog();
                                  },
                                );
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                    color: Color(0xff991F36),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
