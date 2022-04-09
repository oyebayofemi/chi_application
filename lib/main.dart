import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chi_application/application/pages/authentication/login_page.dart';
import 'package:chi_application/application/pages/authentication/wrapper.dart';
import 'package:chi_application/application/pages/screens/home_pages.dart';
import 'package:chi_application/application/services/AuthServiceController.dart';
import 'package:chi_application/lifecycle_manager.dart';
import 'package:chi_application/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CHIApp());
}

class CHIApp extends StatefulWidget {
  CHIApp({Key? key}) : super(key: key);

  @override
  State<CHIApp> createState() => _CHIAppState();
}

class _CHIAppState extends State<CHIApp> {
  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthController>(
            create: (context) => AuthController(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  elevation: 0.0, backgroundColor: Color(0xff991F36)),
            ),
            routes: {
              '/login': (context) => LoginPage(),
              '/dashboard': (context) => HomePage(),
              '/wrapper': (context) => Wrapper(),
            },
            home: AnimatedSplashScreen(
                duration: 2000,
                splash: Image.asset('assets/chi full.jpg'),
                nextScreen: Wrapper(),
                splashTransition: SplashTransition.fadeTransition,
                // pageTransitionType: PageTransitionType.scale,
                backgroundColor: Colors.white)),
      ),
    );
  }
}
