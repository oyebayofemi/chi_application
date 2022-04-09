import 'package:chi_application/application/pages/screens/buy_policy/comprehensive_vehicle_information_individual.dart';
import 'package:chi_application/application/pages/screens/buy_policy/customer_information_type.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/snackbar.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MotorComprehensiveCalculator extends StatefulWidget {
  bool buyPolicy;
  String customerID;
  MotorComprehensiveCalculator(
      {required this.buyPolicy, required this.customerID});

  @override
  State<MotorComprehensiveCalculator> createState() =>
      _MotorComprehensiveCalculatorState();
}

class _MotorComprehensiveCalculatorState
    extends State<MotorComprehensiveCalculator> {
  bool _navLoading = false;
  var taskcollections = FirebaseFirestore.instance.collection('customers');
  List<String> months = ['12 months', '6 months', '3 months'];
  String? selectedMonth = '12 months';
  int? duration = 12;
  int? monthValue = 1;
  bool? isExcessChecked = false;
  double? isExcessValue = 0;
  bool? isFloodChecked = false;
  double? isFloodValue = 0;
  bool? isSRCCchecked = false;
  double? isSRCCValue = 0;
  double? totalRateValue;
  double? rateValue = 2.50;
  double? totalRate;
  String rate = '2.50';
  double? vehicleValue = 0;
  double? calculatedPremiumValue = 0;
  var formatter = NumberFormat('#,###,###,000');
  String status = 'New';
  String? policyType = 'Motor Comprehensive';

  @override
  Widget build(BuildContext context) {
    totalRateValue =
        (rateValue! + isExcessValue! + isFloodValue! + isSRCCValue!) / 100;
    totalRate = (rateValue! + isExcessValue! + isFloodValue! + isSRCCValue!);

    calculatedPremiumValue = (totalRateValue! * vehicleValue!) / monthValue!;
    // print(totalRateValue);
    // print(vehicleValue);
    // print(monthValue);

    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Motor Comprehensive Insurance',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'Poppins',
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.maxFinite,
                color: Colors.grey[100],
                child: DropdownButton<String>(
                  underline: Container(),
                  isExpanded: true,
                  //hint: Text('Gender'), // Not necessary for Option 1
                  value: selectedMonth,
                  onChanged: (newValue) {
                    setState(() {
                      selectedMonth = newValue;

                      if (newValue == '3 months') {
                        monthValue = 4;
                        duration = 3;
                      }
                      if (newValue == '6 months') {
                        monthValue = 2;
                        duration = 6;
                      } else if (newValue == '12 months') {
                        monthValue = 1;
                        duration = 12;
                      }
                      print(monthValue);
                    });
                  },
                  items: months.map((gen) {
                    return DropdownMenuItem(
                      child: new Text(gen),
                      value: gen,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.pink,
                title: Transform.translate(
                  offset: const Offset(-20, 0),
                  child: Text.rich(TextSpan(
                      text: "With Excess (An additional 0.25% applies)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                            child: Icon(
                              FontAwesomeIcons.question,
                              color: Color(0xff991F36),
                              size: 17,
                            ),
                          ),
                        )
                      ])),
                ),
                value: isExcessChecked,
                onChanged: (newValue) {
                  setState(() {
                    isExcessChecked = newValue;

                    if (newValue == true) {
                      isExcessValue = 0.25;
                    } else if (newValue == false) {
                      isExcessValue = 0;
                    }
                  });

                  print(isExcessValue);
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.pink,
                title: Transform.translate(
                  offset: const Offset(-20, 0),
                  child: Text.rich(TextSpan(
                      text: "With Flood (An additional 0.25% applies)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                            child: Icon(
                              FontAwesomeIcons.question,
                              color: Color(0xff991F36),
                              size: 17,
                            ),
                          ),
                        )
                      ])),
                ),
                value: isFloodChecked,
                onChanged: (newValue) {
                  setState(() {
                    isFloodChecked = newValue;

                    if (newValue == true) {
                      isFloodValue = 0.25;
                    } else if (newValue == false) {
                      isFloodValue = 0;
                    }
                  });

                  print(isFloodValue);
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              CheckboxListTile(
                checkColor: Colors.white,
                activeColor: Colors.pink,
                title: Transform.translate(
                  offset: const Offset(-20, 0),
                  child: Text.rich(TextSpan(
                      text: "With SRCC (An additional 0.25% applies)",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      children: [
                        WidgetSpan(
                          child: SizedBox(
                            child: Icon(
                              FontAwesomeIcons.question,
                              color: Color(0xff991F36),
                              size: 17,
                            ),
                          ),
                        )
                      ])),
                ),
                value: isSRCCchecked,
                onChanged: (newValue) {
                  setState(() {
                    isSRCCchecked = newValue;

                    if (newValue == true) {
                      isSRCCValue = 0.25;
                    } else if (newValue == false) {
                      isSRCCValue = 0;
                    }
                  });

                  print(isSRCCValue);
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rate',
                      style: TextStyle(
                        color: Colors.grey[600],
                        //fontWeight: FontWeight.bold,
                        //fontFamily: 'Poppins',
                        //fontSize: 16,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  enabled: false,
                  // readOnly: true,
                  decoration: InputDecoration(
                    hintText: '2.50',
                  ),
                ),
              ),
              SizedBox(
                height: 9,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vehicle Value',
                      style: TextStyle(
                        color: Colors.grey[600],
                        //fontWeight: FontWeight.bold,
                        //fontFamily: 'Poppins',
                        //fontSize: 16,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  // enabled: false,
                  // readOnly: true,
                  onChanged: (value) {
                    double values = double.parse(value);
                    setState(() {
                      if (value.isEmpty) {
                        vehicleValue = 0;
                      } else if (values < 750000) {
                        vehicleValue = 0;
                        showToast(
                            'Sum assured should be at least 750,0000 naira');
                      } else {
                        vehicleValue = double.parse(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: '${vehicleValue?.ceil()}',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Premium(Total Rate Applied:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$totalRate %):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${formatter.format(calculatedPremiumValue?.ceil())}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '**Rates are only applicable to Cars/Saloon and do NOT include trucks or commercial Vehicles.**',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                height: 20,
              ),
              widget.buyPolicy
                  ? ButtonTheme(
                      buttonColor: Color(0xff991F36),
                      minWidth: double.infinity,
                      height: 90,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: RaisedButton(
                        onPressed: () async {
                          if (vehicleValue == 0) {
                            showSnackBar(context, 'Vehicle value cant be null');
                          } else {
                            setState(() {
                              _navLoading = true;
                            });
                            await taskcollections
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('customers')
                                .doc(widget.customerID)
                                .update({
                              'vehicleValue': vehicleValue,
                              'status': status,
                              'policyType': policyType,
                              'premium': calculatedPremiumValue,
                              'duration': duration,
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MotorComprehensiveVehicleInformation(
                                          customerID: widget.customerID),
                                ));
                            setState(() {
                              _navLoading = false;
                            });
                          }
                        },
                        child: _navLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Compute Premium',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    )
                  : ButtonTheme(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
