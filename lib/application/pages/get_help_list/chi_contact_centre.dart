import 'package:chi_application/application/shared/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCentre extends StatefulWidget {
  bool loggedin;
  ContactCentre({required this.loggedin});

  @override
  State<ContactCentre> createState() => _ContactCentreState();
}

class _ContactCentreState extends State<ContactCentre> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.loggedin) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboard', (Route<dynamic> route) => false);
          return false;
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst);
          return false;
        }
      },
      child: Scaffold(
        appBar: widget.loggedin
            ? AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'CHI Contact Centre',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              )
            : AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'CHI Contact Centre',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              ),
        drawer: widget.loggedin ? drawers() : null,
        body: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            height: 60,
            width: double.infinity,
            child: Text('Click below to contact us'),
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              //color: Colors.red,
              height: 30,
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 20,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '+0700-CHINSURANCE',
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
            onTap: () async {
              String phone = '+23412912543';
              lauchdailer(phone);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                //color: Colors.red,
                height: 30,
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '+234 12912543',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
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
            onTap: () async {
              String phone = '+23412912532';
              lauchdailer(phone);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                //color: Colors.red,
                height: 30,
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '+234 12912532',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
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
            onTap: () async {
              String phone = '+2349056037852';
              lauchdailer(phone);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                //color: Colors.red,
                height: 30,
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.whatsapp,
                        size: 20, color: Colors.green),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '09056037852',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
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
            onTap: () async {
              launchEmail();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                //color: Colors.red,
                height: 30,
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'info@chiplc.com',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
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
            thickness: 0.7,
            height: 10,
            color: Colors.grey,
          ),
          GestureDetector(
            onTap: () async {
              launchTwitter();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                //color: Colors.red,
                height: 30,
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.twitter,
                      size: 20,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '@mychiplc',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
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
            onTap: () async {
              launchInstagram();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                //color: Colors.red,
                height: 30,
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.instagram,
                      size: 20,
                      color: Color(0xff833AB4),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'mychiplc',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.red,
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
        ]),
      ),
    );
  }
}

lauchdailer(String phone) async {
  String url = ('tel:$phone');

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Try again');
  }
}

launchEmail() async {
  String email = 'info@chiplc.com?';
  String url = 'mailto:$email';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Cant open Email try again');
  }
}

launchInstagram() async {
  var profile = 'mychiplc';
  var url = 'https://www.instagram.com/$profile/';

  if (await canLaunch(url)) {
    await launch(
      url,
      universalLinksOnly: true,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    );
  } else {
    throw 'There was a problem to open the url: $url';
  }
}

launchTwitter() async {
  var profile = '@mychiplc';
  var url = 'https://www.twitter.com/$profile/';

  if (await canLaunch(url)) {
    await launch(
      url,
      universalLinksOnly: true,
      forceSafariVC: true,
      forceWebView: true,
      enableJavaScript: true,
    );
  } else {
    throw 'There was a problem to open the url: $url';
  }
}
