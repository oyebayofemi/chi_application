import 'package:chi_application/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (value.exists) {
      userModel = UserModel(
        email: value.get('email'),
        phone: value.get('phone'),
        gender: value.get('gender'),
        firstname: value.get('firstname'),
        isChecked: value.get('isChecked'),
        lastname: value.get('lastname'),
        uid: value.get('uid'),
        url: value.get('url'),
        username: value.get('username'),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel? get currentUserData {
    return currentData;
  }
}
