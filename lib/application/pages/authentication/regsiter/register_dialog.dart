import 'package:chi_application/application/pages/authentication/forgot/email_forgot_widget.dart';
import 'package:chi_application/application/pages/authentication/forgot/policy_reg_no_forgot_widget.dart';
import 'package:chi_application/application/pages/authentication/forgot/username_forgot_widget.dart';
import 'package:chi_application/application/pages/authentication/regsiter/register_with_email.dart';
import 'package:chi_application/application/pages/authentication/regsiter/register_with_policyno_or_regno.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class RegisterDialog extends StatelessWidget {
  const RegisterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        alignment: Alignment.centerLeft,
        height: 150,
        width: 700,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Do you have a policy with us?',
                textAlign: TextAlign.left,
              ),
              Spacer(),
              Container(
                //color: Colors.green,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Text('')),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterWithEmail(),
                            ));
                      },
                      child: Text(
                        'NO',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 255, 65, 112),
                          fontWeight: FontWeight.bold,
                          // fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RegisterWithPolicyOrVechileNO(),
                            ));
                      },
                      child: Text(
                        'YES',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 255, 65, 112),
                          fontWeight: FontWeight.bold,
                          // fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
