import 'package:chi_application/application/pages/get_help_list/about_us/about_us.dart';
import 'package:chi_application/application/pages/get_help_list/branch_location/branch_locations.dart';
import 'package:chi_application/application/pages/get_help_list/chi_contact_centre.dart';
import 'package:chi_application/application/pages/get_help_list/frequently_asked_questions/frequently_asked_questions.dart';
import 'package:chi_application/application/pages/get_help_list/product_information/product_information.dart';
import 'package:chi_application/application/shared/forgot_username_email_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetHelp extends StatefulWidget {
  GetHelp({Key? key}) : super(key: key);

  @override
  State<GetHelp> createState() => _GetHelpState();
}

class _GetHelpState extends State<GetHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xff991F36),
        elevation: 0,
        title: Text(
          'Get Help',
          style: TextStyle(
            //color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            //fontFamily: 'Poppins',
            fontSize: 16,
          ),
        ),
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutUS(
                    loggedin: false,
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              //color: Colors.red,
              height: 50,
              child: Row(
                children: [
                  Icon(
                    Icons.check_box,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'About Us',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        //fontFamily: 'Poppins',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          thickness: 0.4,
          height: 10,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BranchLocations(
                    loggedin: false,
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              //color: Colors.red,
              height: 50,
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Branch Locations',
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        //fontFamily: 'Poppins',
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          thickness: 0.4,
          height: 10,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactCentre(
                    loggedin: false,
                  ),
                ));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            //color: Colors.red,
            height: 50,
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'CHI Contact Centre',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      //fontFamily: 'Poppins',
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.4,
          height: 10,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FrequentlyAskedQuestions(
                    loggedin: false,
                  ),
                ));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            //color: Colors.red,
            height: 50,
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.question,
                  color: Color(0xff991F36),
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      //fontFamily: 'Poppins',
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.4,
          height: 10,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ForgotUsernameEmailPasswordDialog();
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            //color: Colors.red,
            height: 50,
            child: Row(
              children: [
                Icon(
                  Icons.enhanced_encryption_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Forgot Username/Email/Password?',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      //fontFamily: 'Poppins',
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.4,
          height: 10,
          color: Colors.grey,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductInformation(loggedin: false),
                ));
          },
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            //color: Colors.red,
            height: 50,
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 30,
                  color: Color(0xff991F36),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Product Information',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                      //fontFamily: 'Poppins',
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.4,
          height: 10,
          color: Colors.grey,
        )
      ]),
    );
  }
}
