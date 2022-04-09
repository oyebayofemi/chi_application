import 'package:chi_application/application/pages/authentication/login_page.dart';
import 'package:chi_application/application/pages/authentication/wrapper.dart';
import 'package:chi_application/application/pages/screens/home_pages.dart';
import 'package:chi_application/application/services/AuthServiceController.dart';
import 'package:chi_application/application/shared/form_field_decoration.dart';
import 'package:chi_application/application/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_context/one_context.dart';

class CustomerRegistrationForm extends StatefulWidget {
  late String em;
  CustomerRegistrationForm(this.em);

  @override
  State<CustomerRegistrationForm> createState() =>
      _CustomerRegistrationFormState();
}

class _CustomerRegistrationFormState extends State<CustomerRegistrationForm> {
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.em;
  }

  final formkey = GlobalKey<FormState>();
  String? password,
      username,
      lastname,
      firstname,
      confirmPassword,
      phone,
      selectedGender;
  List<String> gender = ['Male', 'Female'];
  bool? _isChecked = false;
  bool isloading = false;

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
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please fill in the following details',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff991F36),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) => this.username = value,
                  validator: (value) =>
                      value!.isEmpty ? 'User Name Field cant be empty' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormDecoration().copyWith(hintText: 'Username'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) => this.lastname = value,
                  validator: (value) =>
                      value!.isEmpty ? 'Last Name Field cant be empty' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormDecoration().copyWith(hintText: 'Last Name'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) => this.firstname = value,
                  validator: (value) =>
                      value!.isEmpty ? 'First name Field cant be empty' : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormDecoration().copyWith(hintText: 'First Name'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) => this.phone = value,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) => value!.isEmpty
                      ? 'Phone Number Field cant be empty'
                      : null,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormDecoration().copyWith(hintText: 'Phone Number'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) => this.password = value,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password must be more than 6 characters';
                    } else if (value.isEmpty) {
                      return 'Password Field cant be empty';
                    }
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration:
                      textFormDecoration().copyWith(hintText: 'Password'),
                ),
                SizedBox(
                  height: 20,
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
                    } else if (value != password) {
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
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: double.maxFinite,
                  color: Colors.grey[100],
                  child: DropdownButton<String>(
                    underline: Container(),
                    isExpanded: true,
                    hint: Text('Gender'), // Not necessary for Option 1
                    value: selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        selectedGender = newValue;
                      });
                    },
                    items: gender.map((gen) {
                      return DropdownMenuItem(
                        child: new Text(gen),
                        value: gen,
                      );
                    }).toList(),
                  ),
                ),
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
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  buttonColor: Color(0xff991F36),
                  minWidth: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: RaisedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          isloading = true;
                        });
                        try {
                          await AuthController().signUp(
                              password: password!,
                              gender: selectedGender!,
                              firstname: firstname!,
                              isChecked: _isChecked!,
                              lastname: lastname!,
                              context: context,
                              email: email!,
                              phone: phone!,
                              username: username!);
                          setState(() {
                            isloading = false;
                          });

                          Navigator.popUntil(context, (route) => route.isFirst);
                        } catch (e) {
                          setState(() {
                            isloading = false;
                          });
                          print(e.toString());
                        }
                      }
                    },
                    child: isloading
                        ? Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Text(
                            'Complete',
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
      ),
    );
  }
}
