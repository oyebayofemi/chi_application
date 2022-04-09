import 'package:chi_application/application/pages/screens/buy_policy/corperate.dart';
import 'package:chi_application/application/pages/screens/buy_policy/individual.dart';
import 'package:chi_application/application/pages/screens/rate_calculator/motor_comprehensive_calculator.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:flutter/material.dart';

class Quote extends StatefulWidget {
  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/dashboard', (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        drawer: drawers(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff991F36),
          elevation: 0,
          title: Text(
            'CREATE QUOTE',
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
                          builder: (context) => CorperateWidgetForm()));
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
                          Icons.credit_card,
                          color: Color(0xff991F36),
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Corporate',
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
                          builder: (context) => IndividualWidgetForm()));
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
                          Icons.credit_card,
                          color: Color(0xff991F36),
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Individual',
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
}
