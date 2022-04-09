import 'package:chi_application/application/pages/authentication/change_password.dart';
import 'package:chi_application/application/pages/screens/newsletter.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        moveToLastScreen();
        return false;
      },
      child: Scaffold(
        drawer: drawers(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff991F36),
          elevation: 0,
          title: Text(
            'Settings',
            style: TextStyle(
              //color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              //fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ));
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 130,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Color(0xff991F36),
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Newsletter(),
                      ));
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    height: 130,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.newspaper,
                          color: Color(0xff991F36),
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Newsletter Signup',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/dashboard', (Route<dynamic> route) => false);
  }
}
