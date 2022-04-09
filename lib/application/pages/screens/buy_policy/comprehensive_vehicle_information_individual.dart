import 'dart:io';

import 'package:chi_application/application/pages/screens/buy_policy/customer_information_type.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/utils/car_repo.dart';
import 'package:chi_application/utils/state_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class MotorComprehensiveVehicleInformation extends StatefulWidget {
  String customerID;
  MotorComprehensiveVehicleInformation({required this.customerID});

  @override
  State<MotorComprehensiveVehicleInformation> createState() =>
      _MotorComprehensiveVehicleInformationState();
}

class _MotorComprehensiveVehicleInformationState
    extends State<MotorComprehensiveVehicleInformation> {
  var taskcollections = FirebaseFirestore.instance.collection('customers');
  bool _navLoading = false;
  CarRepository carRepo = CarRepository();
  Repository repo = Repository();
  final formkey = GlobalKey<FormState>();
  String? regNo;
  String? chasisNo;
  String? engineNo;
  String? color;
  String? selectedCategorys = 'Choose a Category';
  String? _selectedStateRegistered;
  int? selectedYear;
  int indexs = 0;
  List<String> _states = ["Choose a state"];
  List<String> category = ["choose"];
  List<String> categorys = [
    "Choose a Category",
    "Private",
    "Commercial",
  ];
  List<String> _make = ["Choose a Car"];
  List<String> _brand = ["Choose .."];
  String? _selectedMake;
  String? _selectedbrand;
  bool _isLoading = false;
  bool isLoading = false;
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
  String? insuredType;

  FilePickerResult? result;
  String? _fileName;
  PlatformFile? driverLicense;
  File? displayDriverLicense;

  FilePickerResult? resultMultiple;
  String? _fileNameMultiple;
  PlatformFile? picturesVehicle;
  File? displayPicturesVehicle;
  List<PlatformFile>? files;
  int? totalCount = 0;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.any);

      if (result != null) {
        _fileName = result!.files.first.name;
        driverLicense = result!.files.first;
        displayDriverLicense = File(driverLicense!.path.toString());
        int sizeInBytes = displayDriverLicense!.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);
        if (sizeInMb > 10) {
          // This file is Longer the
          print('to big $_fileName');
        } else {
          print('Filename $_fileName');
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void pickmultiples() async {
    resultMultiple = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.any);

    if (resultMultiple != null) {
      setState(() {
        files = resultMultiple!.files;
      });
    }
  }

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

  getinfo() async {
    var value = await taskcollections
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('customers')
        .doc(widget.customerID)
        .get();

    setState(() {
      insuredType = value.get('insuredType');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinfo();
    _states = List.from(_states)..addAll(repo.getStates());
    _make = List.from(_make)..addAll(carRepo.getMakes());
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

  String premium = '';
  int premiumValue = 0;
  String classes = '';
  String classesValue = '';
  @override
  Widget build(BuildContext context) {
    years.sort((b, a) => a.compareTo(b));
    if (resultMultiple != null) {
      totalCount = files?.length;
    }

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
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
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
                insuredType == null
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff991F36),
                        ),
                      )
                    : Container(
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
                                      value: selectedCategorys,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCategorys = newValue;
                                        });
                                      },
                                      validator: (String? value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please select a valid Category';
                                        }
                                      },
                                      items: categorys.map((item) {
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
                                  child: DropdownButtonFormField<String>(
                                      //underline: Container(),
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        isCollapsed: true,
                                        border: InputBorder.none,
                                      ),
                                      hint: Text('Choose a make..'),
                                      value: _selectedMake,
                                      onChanged: (newValue) {
                                        _onSelectedMake(newValue!);
                                      },
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please select a valid Brand';
                                        }
                                      },
                                      items: _make.map((item) {
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
                                      : DropdownButtonFormField<String>(
                                          //underline: Container(),
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            isCollapsed: true,
                                            border: InputBorder.none,
                                          ),
                                          hint: Text('Choose a brand..'),
                                          value: _selectedbrand,
                                          onChanged: (newValue) {
                                            _onSelectedBrand(newValue!);
                                            try {
                                              getIndex(newValue);
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          validator: (value) {
                                            if (value?.isEmpty ?? true) {
                                              return 'Please select a valid Brand';
                                            }
                                          },
                                          items: _brand.map((item) {
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
                                    '$classesValue',
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
                                      LengthLimitingTextInputFormatter(10),
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
                              height: 5,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Picture(s) of Vehicle',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Expanded(
                                            child: InkWell(
                                            onTap: () {
                                              pickmultiples();
                                            },
                                            child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(Icons.reorder)),
                                          ))
                                  ],
                                ),
                                if (resultMultiple != null)
                                  SizedBox(
                                    height: 200,
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Container(
                                          //color: Colors.red,
                                          height: 160,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 0.1,
                                              childAspectRatio: 0.1,
                                              crossAxisCount: 5,
                                            ),
                                            itemBuilder: (context, index) {
                                              final f = files![index];
                                              // totalCount = index + 1;

                                              return Column(
                                                children: [
                                                  Image.file(
                                                      File(f.path.toString())),
                                                ],
                                              );
                                            },
                                            itemCount: files!.length,
                                          ),
                                        ),
                                        Text(
                                            'Total number of selected image is: ${totalCount.toString()}'),
                                      ],
                                    ),
                                  )
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Drivers License',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                      ),
                                    )),
                                    isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Expanded(
                                            child: InkWell(
                                            onTap: () {
                                              pickFile();
                                            },
                                            child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(Icons.reorder)),
                                          ))
                                  ],
                                ),
                                if (driverLicense != null)
                                  SizedBox(
                                    height: 50,
                                    width: 300,
                                    child: Image.file(displayDriverLicense!),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 50,
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
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('customers')
                            .doc(widget.customerID)
                            .update({
                          'make': _selectedMake,
                          'brand': _selectedbrand,
                          'class': classesValue,
                          'category': selectedCategorys,
                          'premium': premiumValue,
                          'year': selectedYear,
                          'regNo': regNo,
                          'chasisNo': chasisNo,
                          'color': color,
                          'engineNo': engineNo,
                          'stateRegistered': _selectedStateRegistered
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomerInformationTypeWidget(
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
