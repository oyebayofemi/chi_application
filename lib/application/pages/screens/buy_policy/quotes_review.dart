import 'package:chi_application/application/services/database.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuoteReview extends StatefulWidget {
  String customerID;
  bool isBuyPolicy;

  QuoteReview({
    required this.isBuyPolicy,
    required this.customerID,
  });

  @override
  State<QuoteReview> createState() => _QuoteReviewState();
}

class _QuoteReviewState extends State<QuoteReview> {
  var taskcollections = FirebaseFirestore.instance.collection('customers');
  bool _delLoading = false;
  String? _make;
  String? _selectedID;
  String? _idNumber;
  String? _brand;
  String? _classes;
  String? _category;
  int? _year;
  String? _regNo;
  String? _chasisNo;
  String? _color;
  String? _engineNo;
  String? _stateRegistered;
  int? _premium;
  int? _duration;
  String? _status;
  Timestamp? _dates;
  String? _insuredType,
      _companyName,
      _phone,
      _gender,
      _email,
      _firstName,
      _lastName,
      narration,
      _title;
  String? _address,
      _country,
      _businessType,
      _rcNo,
      _selectedState,
      _selectedLGA;
  var _dateValue;
  getinfo() async {
    var value = await taskcollections
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('customers')
        .doc(widget.customerID)
        .get();

    setState(() {
      _make = value.get('make');
      _brand = value.get('brand');
      _classes = value.get('class');

      _phone = value.get('phone');
      _email = value.get('email');
      _make = value.get('make');
      _brand = value.get('brand');
      _classes = value.get('class');
      _category = value.get('category');
      _year = value.get('year');
      _regNo = value.get('regNo');
      _chasisNo = value.get('chasisNo');
      _color = value.get('color');
      _engineNo = value.get('engineNo');
      _stateRegistered = value.get('stateRegistered');
      _premium = value.get('premium');
      _duration = value.get('duration');
      _status = value.get('status');
      _dates = value.get('time');
      _insuredType = value.get('insuredType');
      _address = value.get('address');
      _country = value.get('country');
      _businessType = value.get('businessType');

      _dateValue = value.get('policyCommencementDate');
      _selectedLGA = value.get('stateOfResidenceLGA');
      _selectedState = value.get('stateOfResidence');
    });
  }

  @override
  void initState() {
    super.initState();
    getinfo();
  }

  String? load;
  getCorperateInfo() async {
    var value = await taskcollections
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('customers')
        .doc(widget.customerID)
        .get();

    setState(() {
      _companyName = value.get('companyName');
      _rcNo = value.get('rcNo');
      load = 'k';
      narration = 'RC Number';
    });
  }

  getIndividualInfo() async {
    var value = await taskcollections
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('customers')
        .doc(widget.customerID)
        .get();

    setState(() {
      _firstName = value.get('firstName');
      _lastName = value.get('lastName');
      _title = value.get('title');
      _gender = value.get('gender');
      _selectedID = value.get('meansOfID');
      _idNumber = value.get('idNo');
      narration = _selectedID;

      load = 'k';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getIndividualInfo();
    getCorperateInfo();
  }

  @override
  Widget build(BuildContext context) {
    if (_insuredType != null) {
      if (_insuredType == 'Corperate') {
        getCorperateInfo();
      } else {
        getIndividualInfo();
      }
    }
    return Scaffold(
        drawer: drawers(),
        appBar: widget.isBuyPolicy
            ? AppBar(
                actions: [
                  PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 0) {
                        setState(() {
                          _delLoading = true;
                        });
                        await DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .deleteQuote(widget.customerID);
                        await showToast('Deleted successfully');
                        await Navigator.of(context).pushNamedAndRemoveUntil(
                            '/dashboard', (Route<dynamic> route) => false);
                      }
                    },
                    icon: Icon(Icons.more_vert_rounded),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text('Delete Quote'),
                      ),
                    ],
                  ),
                ],
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
                actions: [
                  PopupMenuButton(
                    onSelected: (value) async {
                      if (value == 0) {
                        setState(() {
                          _delLoading = true;
                        });
                        await DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .deleteQuote(widget.customerID);
                        await showToast('Deleted successfully');
                        await Navigator.of(context).pushNamedAndRemoveUntil(
                            '/dashboard', (Route<dynamic> route) => false);
                      }
                    },
                    icon: Icon(Icons.more_vert_rounded),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text('Delete Quote'),
                      ),
                    ],
                  ),
                ],
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Color(0xff991F36),
                elevation: 0,
                title: Text(
                  'Pending Quotes',
                  style: TextStyle(
                    //color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
              ),
        body: load == null
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xff991F36),
                ),
              )
            : _delLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Color(0xff991F36),
                  ))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Customer Information',
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
                          if (_companyName != null)
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Company Name',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: Text(
                                    '$_companyName',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (_firstName != null)
                            Container(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Title',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(
                                        '$_title',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
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
                                      'First Name',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(
                                        '$_firstName',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
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
                                      'Last Name',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(
                                        '$_lastName',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
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
                                      'Gender',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(
                                        '$_gender',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
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
                                'Insured Type',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_insuredType',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Address',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_address',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Country',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_country',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'LGA',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_selectedLGA',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                          if (_rcNo != null)
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'RC Number',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: Text(
                                    '$_rcNo',
                                    style: TextStyle(
                                      //fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (_firstName != null)
                            Container(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Title',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(
                                        '$_title',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
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
                                      'Means Of ID',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(
                                        '$_selectedID',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
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
                                      'Means Of ID No.',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    Expanded(
                                      child: Text(
                                        '$_idNumber',
                                        style: TextStyle(
                                          //fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
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
                                'Narration',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$narration',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Phone No.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_phone',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Email',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_email',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Occupation/ ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    'Business Type',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              )),
                              Expanded(
                                child: Text(
                                  '$_businessType',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'State',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_selectedState',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Duration',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_duration',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Status',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_status',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                          SizedBox(
                            height: 10,
                          ),
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
                            height: 10,
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
                                'Sum Insured',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '0.00',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Premium',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_premium',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Category',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_category',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Make',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_make',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                  '$_brand',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Classes',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_classes',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                child: Text(
                                  '$_year',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Chasis No',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_chasisNo',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                child: Text(
                                  '$_regNo',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                'Color',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  '$_color',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                child: Text(
                                  '$_engineNo',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                                child: Text(
                                  '$_stateRegistered',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
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
                          SizedBox(
                            height: 50,
                          ),
                          ButtonTheme(
                            buttonColor: Color(0xff991F36),
                            minWidth: double.infinity,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: RaisedButton(
                              onPressed: () async {},
                              child: Text(
                                'Create Policy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
