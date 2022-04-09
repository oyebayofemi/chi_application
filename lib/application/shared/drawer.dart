// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chi_application/application/pages/authentication/wrapper.dart';
import 'package:chi_application/application/pages/get_help_list/about_us/about_us.dart';
import 'package:chi_application/application/pages/get_help_list/branch_location/branch_locations.dart';
import 'package:chi_application/application/pages/get_help_list/chi_contact_centre.dart';
import 'package:chi_application/application/pages/get_help_list/frequently_asked_questions/frequently_asked_questions.dart';
import 'package:chi_application/application/pages/get_help_list/product_information/product_information.dart';
import 'package:chi_application/application/pages/screens/home_pages.dart';
import 'package:chi_application/application/pages/screens/my_policies.dart';
import 'package:chi_application/application/pages/screens/my_profile.dart';
import 'package:chi_application/application/pages/screens/pending_quotes.dart';
import 'package:chi_application/application/pages/screens/quote.dart';
import 'package:chi_application/application/pages/screens/rate_calculator.dart';
import 'package:chi_application/application/pages/settings.dart';
import 'package:chi_application/application/services/AuthServiceController.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

class drawers extends StatelessWidget {
  const drawers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    var userData = userProvider.currentUserData;
    return Drawer(
      child: ListView(padding: EdgeInsets.all(0), children: <Widget>[
        /*DrawerHeader(
          child: Text('Hello'),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),*/

        // UserAccountsDrawerHeader(
        //   decoration: BoxDecoration(
        //     color: Color(0xff991F36),
        //   ),
        //   accountName: Text('username'),
        //   accountEmail: Text(''),
        //   currentAccountPicture: CircleAvatar(
        //     backgroundImage: NetworkImage(
        //       '',
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 160,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(),
                  ));
            },
            child: userData == null
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xff991F36)),
                  )
                : DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xff991F36),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(userData.url ??
                              'https://i.stack.imgur.com/l60Hf.png'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          '${userData.username}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.event,
              color: Color(0xff991F36),
              //size: 30,
            ),
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Color(0xff991F36),
            ),
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.format_list_bulleted,
              color: Color(0xff991F36),
            ),
            title: Text('My Policies'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPolicy(),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.people,
              color: Color(0xff991F36),
            ),
            title: Text('My Renewals'),
            onTap: () {},
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.shop,
              color: Color(0xff991F36),
            ),
            title: Text('Buy Policy'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Quote(),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Color(0xff991F36),
            ),
            title: Text('Product Information'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductInformation(loggedin: true),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.hourglass_empty,
              color: Color(0xff991F36),
            ),
            title: Text('Pending Quotes'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PendingQuotes(),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.calculate,
              color: Color(0xff991F36),
            ),
            title: Text('Rate Calculator'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RateCalculator(
                      buyPolicy: false,
                      customerID: '',
                      insuredType: '',
                    ),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.account_balance,
              color: Color(0xff991F36),
            ),
            title: Text('Branch Locations'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BranchLocations(
                      loggedin: true,
                    ),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.question,
              color: Color(0xff991F36),
            ),
            title: Text('FAQs'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FrequentlyAskedQuestions(
                      loggedin: true,
                    ),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.check_box,
              color: Color(0xff991F36),
            ),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUS(
                      loggedin: true,
                    ),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.phone,
              color: Color(0xff991F36),
            ),
            title: Text('Contact Us'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactCentre(loggedin: true),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: Color(0xff991F36),
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ));
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: (() async {
            final auth = Provider.of<AuthController>(context, listen: false);

            await AuthController().signout();
            removeAllAndPush(Wrapper(), context);
          }),
          child: Container(
            height: 40,
            color: Color(0xff991F36),
            alignment: Alignment.center,
            child: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
        ),
      ]),
    );
  }
}

removeAllAndPush(Widget destination, BuildContext context) {
  try {
    // Navigator.pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (context) => destination),
    //   (route) => false,
    // );
    // OneContext()
    //     .pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
    Navigator.popUntil(context, (route) => route.isFirst);
  } catch (e) {
    print("Error while navigating : $e");
  }
}
