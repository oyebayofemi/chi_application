import 'package:chi_application/application/services/AuthServiceController.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String? oldPassword, newPassword, confirmPassword;
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool checkPasswordValid = true;
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
      body: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Old Password',
                      style: TextStyle(
                        color: Color(0xff991F36),
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) => this.oldPassword = value,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Old Password must be more than 6 characters';
                        } else if (value.isEmpty) {
                          return 'Old Password Field cant be empty';
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: textFormDecoration().copyWith(
                          hintText: 'Old Password',
                          errorText: checkPasswordValid
                              ? null
                              : 'Please double check your current password!!'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'New Password',
                      style: TextStyle(
                        color: Color(0xff991F36),
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) => this.newPassword = value,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'New Password must be more than 6 characters';
                        } else if (value.isEmpty) {
                          return 'New Password Field cant be empty';
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: textFormDecoration()
                          .copyWith(hintText: 'New Password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Confirm New Password',
                      style: TextStyle(
                        color: Color(0xff991F36),
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) => this.confirmPassword = value,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Confirm Password must be more than 6 characters';
                        } else if (value.isEmpty) {
                          return 'Confirm Password Field cant be empty';
                        } else if (value != newPassword) {
                          return 'Password doesnt match';
                        }
                      },
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: textFormDecoration()
                          .copyWith(hintText: 'Confirm Password'),
                    ),
                    SizedBox(
                      height: 20,
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
                        setState(() {
                          _isLoading = true;
                        });
                        checkPasswordValid = await AuthController()
                            .checkCurrentPassword(oldPassword!);
                        setState(() {});
                        setState(() {
                          _isLoading = false;
                        });
                        if (checkPasswordValid) {
                          setState(() {
                            _isLoading = true;
                          });
                          AuthController().updateUserPassword(newPassword!);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Change Password',
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
          )),
    );
  }
}
