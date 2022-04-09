import 'package:chi_application/application/pages/screens/rate_calculator/motor_comprehensive_calculator.dart';
import 'package:chi_application/application/pages/screens/rate_calculator/third_party_calculator.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:flutter/material.dart';

class RateCalculator extends StatefulWidget {
  bool buyPolicy;
  String customerID;
  String insuredType;
  RateCalculator(
      {required this.buyPolicy,
      required this.customerID,
      required this.insuredType});

  @override
  State<RateCalculator> createState() => _RateCalculatorState();
}

class _RateCalculatorState extends State<RateCalculator> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.buyPolicy) {
          Navigator.pop(context);
          return false;
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/dashboard', (Route<dynamic> route) => false);
          return false;
        }
      },
      child: Scaffold(
        drawer: drawers(),
        appBar: widget.buyPolicy
            ? AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'Buy Policy',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              )
            : AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'Rate Calculator',
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
                        builder: (context) => ThirdPartyCalculator(
                            buyPolicy: widget.buyPolicy,
                            customerID: widget.customerID,
                            insuredType: widget.insuredType),
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
                          Icons.credit_card,
                          color: Color(0xff991F36),
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Motor Third Party',
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
                        builder: (context) => MotorComprehensiveCalculator(
                            buyPolicy: widget.buyPolicy,
                            customerID: widget.customerID),
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
                          Icons.credit_card,
                          color: Color(0xff991F36),
                          size: 50,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Motor Comprehensive Insurance',
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
