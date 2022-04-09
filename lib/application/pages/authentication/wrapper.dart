import 'package:chi_application/application/pages/authentication/login_page.dart';
import 'package:chi_application/application/pages/screens/home_pages.dart';
import 'package:chi_application/application/services/AuthServiceController.dart';
import 'package:chi_application/application/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthController().authChanges(),
      builder: (context, snapshot) {
        final provider = Provider.of<AuthController>(context, listen: false);
        if (provider.isSigningIn) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
