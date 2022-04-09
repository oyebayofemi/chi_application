import 'package:chi_application/application/pages/screens/buy_policy/motor_third_party_vehicle_information.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/snackbar.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:chi_application/utils/car_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdPartyCalculator extends StatefulWidget {
  bool buyPolicy;
  String customerID;
  String insuredType;
  ThirdPartyCalculator(
      {required this.buyPolicy,
      required this.customerID,
      required this.insuredType});

  @override
  State<ThirdPartyCalculator> createState() => _ThirdPartyCalculatorState();
}

class _ThirdPartyCalculatorState extends State<ThirdPartyCalculator> {
  CarRepository carRepo = CarRepository();
  var taskcollections = FirebaseFirestore.instance.collection('customers');

  List<String> _make = ["Choose a Car"];
  List<String> _brand = ["Choose .."];
  String? _selectedMake;
  String? _selectedbrand;
  List<String> category = ["choose"];
  int indexs = 0;
  int monthValue = 12;
  String status = 'New';
  String? policyType = 'Third Party';
  double? vehicleValue = 0.00;

  bool _isLoading = false;
  bool _navLoading = false;

  void _onSelectedMake(String value) async {
    setState(() {
      _selectedbrand = "Choose ..";
      _selectedMake = value;
      _brand = ["Choose .."];
      category = ['choose'];
      indexs = 0;

      _isLoading = true;
    });

    _brand = List.from(_brand)..addAll(await carRepo.getBrands(value));
    category = List.from(category)..addAll(await carRepo.getCategory(value));

    setState(() {
      _isLoading = false;
    });
  }

  void _onSelectedBrand(String value) async {
    setState(() => _selectedbrand = value);
  }

  void getIndex(String value) {
    indexs = _brand.indexWhere((item) => item == value);
    setState(() {
      if (category[indexs] == 'Sedan' ||
          category[indexs] == 'Coupe' ||
          category[indexs] == 'Convertible' ||
          category[indexs] == 'SUV' ||
          category[indexs] == 'Wagon' ||
          category[indexs] == 'Hatchback ') {
        setState(() {
          premium = 'Premium: 5,000.00';
          premiumValue = 5000;
          classes = 'Class: CAR';
          classesValue = 'Car';
        });
      } else if (category[indexs] == 'Pickup' ||
          category[indexs] == 'Minivan' ||
          category[indexs] == 'Van') {
        setState(() {
          premium = 'Premium: 7,500.00';
          premiumValue = 7500;
          classes = 'Class: BUS';
          classesValue = 'Bus';
        });
      } else if (category[indexs] == 'Tricycle') {
        setState(() {
          premium = 'Premium: 2,500.00';
          premiumValue = 2500;
          classes = 'Class: Tricycle';
          classesValue = 'Tricycle';
        });
      } else if (category[indexs] == 'Truck') {
        setState(() {
          premium = 'Premium: 10,000.00';
          premiumValue = 1000;
          classes = 'Class: Truck';
          classesValue = 'Truck';
        });
      } else {
        setState(() {
          premium = '';
          premiumValue = 0;
          classes = '';
          classesValue = '';
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _make = List.from(_make)..addAll(carRepo.getMakes());
  }

  String premium = '';
  int premiumValue = 0;
  String classes = '';
  String classesValue = '';

  @override
  Widget build(BuildContext context) {
    // print(_make);
    // print(_brand);
    // print(category);
    // print(indexs);
    // print(category[indexs]);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    var userData = userProvider.currentUserData;
    String uid = userData!.uid!;

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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Make',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      )),
                      Expanded(
                        child: DropdownButton<String>(
                          underline: Container(),
                          isExpanded: true,
                          hint: Text(
                              'Choose a make.. '), // Not necessary for Option 1
                          value: _selectedMake,
                          onChanged: (newValue) {
                            _onSelectedMake(newValue!);
                          },
                          items: _make.map((item) {
                            return DropdownMenuItem(
                              child: Text(item),
                              value: item.toString(),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Brand',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      )),
                      Expanded(
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff991F36),
                                ),
                              )
                            : DropdownButton<String>(
                                underline: Container(),
                                isExpanded: true,
                                hint: Text(
                                    'Choose a brand..'), // Not necessary for Option 1
                                value: _selectedbrand,
                                onChanged: (newValue) {
                                  _onSelectedBrand(newValue!);
                                  try {
                                    getIndex(newValue);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                items: _brand.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item),
                                    value: item.toString(),
                                  );
                                }).toList(),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    premium,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w800,
                      fontSize: 27,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    classes,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w800,
                      fontSize: 27,
                    ),
                  ),
                ],
              ),
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
                        if (_selectedMake == null ||
                            _selectedbrand == null ||
                            _selectedMake == 'Choose a Car' ||
                            _selectedbrand == 'Choose ..') {
                          //print('object');
                          showSnackBar(context, 'Make/Brand cant be null');
                        } else {
                          setState(() {
                            _navLoading = true;
                          });
                          //print('we');
                          await taskcollections
                              .doc(uid)
                              .collection('customers')
                              .doc(widget.customerID)
                              .update({
                            'make': _selectedMake,
                            'brand': _selectedbrand,
                            'class': classesValue,
                            'premium': premiumValue,
                            'duration': monthValue,
                            'status': status,
                            'policyType': policyType,
                            'vehicleValue': vehicleValue,
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MotorThirdPartyVehicleInformation(
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
                              'Next',
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
    );
  }
}
