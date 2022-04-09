import 'dart:typed_data';

import 'package:chi_application/application/services/storage.dart';
import 'package:chi_application/application/shared/drawer.dart';
import 'package:chi_application/application/shared/loading_dialog.dart';
import 'package:chi_application/application/shared/toast.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:chi_application/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Uint8List? _image;
  StorageMethods storageMethods = StorageMethods();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  selectImageCamera() async {
    Uint8List im = await pickImage(ImageSource.camera);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  selectImageGallery() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  uploadToFirebase() async {
    try {
      String url = await storageMethods.uploadFile(
          _image!); // this will upload the file and store url in the variable 'url'
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        //use update to update the doc fields.
        'url': url
      });
      showToast('Success');
    } catch (e) {
      showToast('Couldnt Upload file');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    var userData = userProvider.currentUserData;
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
            'My Profile',
            style: TextStyle(
              //color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              //fontFamily: 'Poppins',
              fontSize: 16,
            ),
          ),
        ),
        body: userData == null
            ? Center(
                child: CircularProgressIndicator(color: Color(0xff991F36)),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (builder) => bottomSheet());

                      await uploadToFirebase();
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(userData.url ??
                              'https://i.stack.imgur.com/l60Hf.png'),
                        ),
                        Positioned(
                            top: 100,
                            left: 15,
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 30,
                              color: Colors.white,
                              child: Text('update'),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                        Expanded(
                            child: Text(
                          userData.username!,
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                        Expanded(
                            child: Text(
                          '${userData.lastname!} ${userData.firstname!}',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Gender',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                        Expanded(
                            child: Text(
                          '${userData.gender!}',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Phone No.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                        Expanded(
                            child: Text(
                          '${userData.phone!}',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                        Expanded(
                            child: Text(
                          '${userData.email!}',
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.grey[700]),
                        )),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 70,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: FlatButton.icon(
                    onPressed: () async {
                      await selectImageCamera();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('Camera')),
              ),
              Expanded(
                child: FlatButton.icon(
                    onPressed: () async {
                      await selectImageGallery();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.photo_size_select_actual_rounded),
                    label: Text('Gallery')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
