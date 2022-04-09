import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? email;
  final String? username;
  final String? lastname;
  final String? firstname;
  final String? phone;
  final String? gender;
  final bool? isChecked;
  final String? url;

  UserModel(
      {this.email,
      this.uid,
      this.username,
      this.firstname,
      this.lastname,
      this.gender,
      this.isChecked,
      this.phone,
      this.url});

  Map<String, dynamic> toJson() => {
        'username': username,
        'lastname': lastname,
        'firstname': firstname,
        'gender': gender,
        'isChecked': isChecked,
        'uid': uid,
        'email': email,
        'phone': phone,
        'url': url,
      };

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        username: snapshot["username"],
        lastname: snapshot['lastname'],
        firstname: snapshot['firstname'],
        gender: snapshot['gender'],
        isChecked: snapshot['isChecked'],
        uid: snapshot["uid"],
        email: snapshot["email"],
        url: snapshot["url"],
        phone: snapshot['phone']);
  }
}
