import 'package:chi_application/application/pages/screens/buy_policy/quotes_review.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:chi_application/utils/state_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomerInformationCorperate extends StatefulWidget {
  String customerID;
  CustomerInformationCorperate({required this.customerID});

  @override
  State<CustomerInformationCorperate> createState() =>
      _CustomerInformationCorperateState();
}

class _CustomerInformationCorperateState
    extends State<CustomerInformationCorperate> {
  final _formkey = GlobalKey<FormState>();
  bool _navLoading = false;
  Repository repo = Repository();
  List<String> _states = ["Choose a state"];
  List<String> _lgas = ["Choose .."];
  String? _selectedState;
  String? _selectedLGA;
  String? email,
      _policyType,
      phone,
      address,
      country = 'Nigeria',
      companyName,
      businessType,
      rcNo;
  bool _isLoading = false;
  DateTime? date;
  var myFormat = DateFormat('d-MM-yyyy');
  var dateValue = '';

  var taskcollections = FirebaseFirestore.instance.collection('customers');
  var pendingcollections = FirebaseFirestore.instance.collection('quote');
  String? _make;
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
  String? _insuredType;
  double? vehicleValue;

  getinfo() async {
    var value = await taskcollections
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('customers')
        .doc(widget.customerID)
        .get();

    setState(() {
      companyName = value.get('companyName');

      phone = value.get('phone');
      vehicleValue = value.get('vehicleValue');
      email = value.get('email');
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
      _policyType = value.get('policyType');
    });
  }

  void _onSelectedState(String value) async {
    setState(() {
      _selectedLGA = "Choose ..";
      _selectedState = value;
      _lgas = ["Choose .."];
      _isLoading = true;
    });

    _lgas = List.from(_lgas)..addAll(await repo.getLocalByState(value));

    setState(() {
      _isLoading = false;
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinfo();
    _states = List.from(_states)..addAll(repo.getStates());
  }

  setDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month + 1, DateTime.now().day));

    if (newDate == null) return;
    setState(() {
      date = newDate;
      dateValue = '${myFormat.format(newDate)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: companyName == null
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff991F36),
              ),
            )
          : Form(
              key: _formkey,
              child: SingleChildScrollView(
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
                        height: 20,
                      ),
                      Container(
                        child: Column(
                          children: [
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
                                  child: TextFormField(
                                    initialValue: companyName,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,
                                    onChanged: (value) => companyName = value,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   LengthLimitingTextInputFormatter(10),
                                    // ],
                                    validator: (value) => value!.isEmpty
                                        ? 'Company Name Field cant be empty'
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
                                  'Phone Number',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: phone,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,
                                    onChanged: (value) => phone = value,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                    ],
                                    validator: (value) => value!.isEmpty
                                        ? 'Phone Number Field cant be empty'
                                        : null,
                                    keyboardType: TextInputType.number,
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
                                  'Email',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: email,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,
                                    onChanged: (value) => email = value,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   LengthLimitingTextInputFormatter(10),
                                    // ],
                                    validator: (value) => value!.isEmpty
                                        ? 'Email Address Field cant be empty'
                                        : null,
                                    keyboardType: TextInputType.emailAddress,
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
                                  'Address',
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
                                    onChanged: (value) => address = value,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(200),
                                    ],
                                    //maxLines: 6,
                                    //maxLength: 100,
                                    validator: (value) => value!.isEmpty
                                        ? 'Address Field cant be empty'
                                        : null,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.newline,
                                    minLines: null,
                                    maxLines: null,
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
                                  'Country',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: country,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ),
                                    //maxLength: 10,
                                    onChanged: (value) => country = value,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   LengthLimitingTextInputFormatter(100),
                                    // ],
                                    //maxLines: 6,
                                    //maxLength: 100,
                                    validator: (value) => value!.isEmpty
                                        ? 'Country Field cant be empty'
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
                                  'State Registered',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                      //underline: Container(),
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      hint: Text('Choose a State..'),
                                      value: _selectedState,
                                      onChanged: (newValue) {
                                        _onSelectedState(newValue!);
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
                                _isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Color(0xff991F36),
                                        ),
                                      )
                                    : Expanded(
                                        child: DropdownButtonFormField<String>(
                                            //underline: Container(),
                                            isExpanded: true,
                                            decoration: InputDecoration(
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ),
                                            hint: Text(
                                                'LGA'), // Not necessary for Option 1
                                            value: _selectedLGA,
                                            onChanged: (newValue) {
                                              _onSelectedLGA(newValue!);
                                            },
                                            validator: (value) {
                                              if (value?.isEmpty ?? true) {
                                                return 'Please select a valid State';
                                              }
                                            },
                                            items: _lgas.map((item) {
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
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Business Type',
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
                                    onChanged: (value) => businessType = value,

                                    validator: (value) => value!.isEmpty
                                        ? 'Occupation Field cant be empty'
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
                                  'RC Number',
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
                                    onChanged: (value) => rcNo = value,

                                    validator: (value) => value!.isEmpty
                                        ? 'RC Number Field cant be empty'
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
                                  'Policy Commencement Date',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  ),
                                )),
                                Expanded(
                                  child: FlatButton(
                                      onPressed: () {
                                        setDate(context);
                                      },
                                      child: Text(dateValue)),
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
                            ButtonTheme(
                              buttonColor: Color(0xff991F36),
                              minWidth: double.infinity,
                              height: 60,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: RaisedButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    if (date == null) {
                                      showToast('Date cant be null');
                                    } else {
                                      setState(() {
                                        _navLoading = true;
                                      });
                                      await taskcollections
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .collection('customers')
                                          .doc(widget.customerID)
                                          .update({
                                        'companyName': companyName,
                                        'phone': phone,
                                        'email': email,
                                        'address': address,
                                        'country': country,
                                        'stateOfResidence': _selectedState,
                                        'stateOfResidenceLGA': _selectedLGA,
                                        'businessType': businessType,
                                        'rcNo': rcNo,
                                        'policyCommencementDate': dateValue,
                                      });
                                      await pendingcollections
                                          .doc(FirebaseAuth
                                              .instance.currentUser?.uid)
                                          .collection('pending')
                                          .doc(widget.customerID)
                                          .set({
                                        'companyName': companyName,
                                        'phone': phone,
                                        'email': email,
                                        'address': address,
                                        'country': country,
                                        'stateOfResidence': _selectedState,
                                        'stateOfResidenceLGA': _selectedLGA,
                                        'businessType': businessType,
                                        'rcNo': rcNo,
                                        'policyCommencementDate': dateValue,
                                        'make': _make,
                                        'brand': _brand,
                                        'class': _classes,
                                        'premium': _premium,
                                        'duration': _duration,
                                        'status': _status,
                                        'category': _category,
                                        'year': _year,
                                        'regNo': _regNo,
                                        'chasisNo': _chasisNo,
                                        'color': _color,
                                        'engineNo': _engineNo,
                                        'stateRegistered': _stateRegistered,
                                        'insuredType': _insuredType,
                                        'time': _dates,
                                        'policyType': _policyType,
                                        'vehicleValue': vehicleValue,
                                      });
                                      showToast(
                                          'Quotes has been added to pending quotes');

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => QuoteReview(
                                                isBuyPolicy: true,
                                                customerID: widget.customerID),
                                          ));
                                      setState(() {
                                        _navLoading = false;
                                      });
                                    }
                                    // print('object');

                                  }
                                },
                                child: _navLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'Create Quote',
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
