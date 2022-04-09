import 'package:chi_application/application/pages/screens/buy_policy/corperate_customer_information.dart';
import 'package:chi_application/application/pages/screens/buy_policy/customer_information_type.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:chi_application/utils/state_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MotorThirdPartyVehicleInformation extends StatefulWidget {
  String customerID;
  MotorThirdPartyVehicleInformation({required this.customerID});

  @override
  State<MotorThirdPartyVehicleInformation> createState() =>
      _MotorThirdPartyVehicleInformationState();
}

class _MotorThirdPartyVehicleInformationState
    extends State<MotorThirdPartyVehicleInformation> {
  // var taskcollections = FirebaseFirestore.instance.collection('customers');
  Repository repo = Repository();
  bool _navLoading = false;
  String? regNo;
  String? chasisNo;
  String? engineNo;
  String? color;
  final formkey = GlobalKey<FormState>();
  String? make;
  String? brand;
  String? classes;
  String? selectedCategory = 'Choose a Category';
  String? _selectedStateRegistered;
  int? selectedYear;
  List<String> _states = ["Choose a state"];
  List<String> category = [
    "Choose a Category",
    "Private",
    "Commercial",
  ];
  List<int> years = [
    1970,
    1971,
    1972,
    1973,
    1974,
    1975,
    1976,
    1977,
    1978,
    1979,
    1980,
    1981,
    1982,
    1983,
    1984,
    1985,
    1986,
    1987,
    1988,
    1989,
    1990,
    1991,
    1992,
    1993,
    1994,
    1995,
    1996,
    1997,
    1998,
    1999,
    2000,
    2001,
    2002,
    2003,
    2004,
    2005,
    2006,
    2007,
    2008,
    2009,
    2010,
    2011,
    2012,
    2013,
    2014,
    2015,
    2016,
    2017,
    2018,
    2019,
    2020,
    2021,
    2022
  ];
  var taskcollections = FirebaseFirestore.instance.collection('customers');
  String? insuredType;
  getinfo() async {
    var value = await taskcollections
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('customers')
        .doc(widget.customerID)
        .get();

    setState(() {
      make = value.get('make');
      brand = value.get('brand');
      classes = value.get('class');
      insuredType = value.get('insuredType');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinfo();
    _states = List.from(_states)..addAll(repo.getStates());
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider = Provider.of(context);
    // userProvider.getUserData();

    // var userData = userProvider.currentUserData;
    // String uid = userData!.uid!;

    years.sort((b, a) => a.compareTo(b));

    return Scaffold(
      drawer: drawers(),
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: insuredType == null
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff991F36),
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        'Vehicle Information',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          //fontFamily: 'Poppins',
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Category',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: DropdownButtonFormField(
                                      //underline: Container(),
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      hint: Text('Choose a Category..'),
                                      value: selectedCategory,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCategory = newValue;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please select a valid Category';
                                        }
                                      },
                                      items: category.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item),
                                          value: item.toString(),
                                        );
                                      }).toList()),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
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
                                  child: Text(
                                    '$make',
                                    style: TextStyle(
                                        //fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.grey[500]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
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
                                  child: Text(
                                    '$brand',
                                    style: TextStyle(
                                        //fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.grey[500]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Year',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: DropdownButtonFormField<int>(
                                      //underline: Container(),
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      hint: Text('Choose a Year..'),
                                      value: selectedYear,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedYear = newValue;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select a valid Year';
                                        }
                                      },
                                      items: years.map((int item) {
                                        return DropdownMenuItem<int>(
                                          child: Text(item.toString()),
                                          value: item,
                                        );
                                      }).toList()),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Class',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: Text(
                                    '$classes',
                                    style: TextStyle(
                                        //fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.grey[500]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Registration No.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,
                                    onChanged: (value) => regNo = value,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    validator: (value) => value!.isEmpty
                                        ? 'Registration Number Field cant be empty'
                                        : null,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.2,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Chasis No.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,
                                    onChanged: (value) => chasisNo = value,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(17),
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ('Chasis Number Field cant be empty');
                                      } else if (value.length < 17) {
                                        return ('Should be 17 characters.');
                                      } else {
                                        return (null);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.7,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Color',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,
                                    onChanged: (value) => color = value,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(17),
                                    ],
                                    validator: (value) => value!.isEmpty
                                        ? 'Color Field cant be empty'
                                        : null,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Engine No.',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,

                                    onChanged: (value) => engineNo = value,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    validator: (value) => value!.isEmpty
                                        ? 'Engine Number Field cant be empty'
                                        : null,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'State Registered',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: DropdownButtonFormField(
                                      //underline: Container(),
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      hint: Text('Choose a State..'),
                                      value: _selectedStateRegistered,
                                      onChanged: (String? nValue) {
                                        setState(() {
                                          _selectedStateRegistered = nValue;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please select a valid State';
                                        }
                                      },
                                      items: _states.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item),
                                          value: item.toString(),
                                        );
                                      }).toList()),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(
                              thickness: 0.4,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            ButtonTheme(
                              buttonColor: Color(0xff991F36),
                              minWidth: double.infinity,
                              height: 60,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: RaisedButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      _navLoading = true;
                                    });
                                    // print('object');
                                    await taskcollections
                                        .doc(FirebaseAuth
                                            .instance.currentUser?.uid)
                                        .collection('customers')
                                        .doc(widget.customerID)
                                        .update({
                                      'category': selectedCategory,
                                      'year': selectedYear,
                                      'regNo': regNo,
                                      'chasisNo': chasisNo,
                                      'color': color,
                                      'engineNo': engineNo,
                                      'stateRegistered':
                                          _selectedStateRegistered
                                    });

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerInformationTypeWidget(
                                                  customerID:
                                                      widget.customerID),
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
