import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sol_flow/pages/on_boarding/onboding_screen.dart';
import '/pages/home_page/home_page_widget.dart';
import '/pages/dashboard/dashboard.dart';
import '/pages/sign_up/signup.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utlis/framwork_utils.dart';
import 'index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green, // the color of the app bar
          accentColor: Colors.red, // the color used for buttons, etc.
          backgroundColor: Colors.white, // the default background color
          scaffoldBackgroundColor:
              Colors.grey[200], // the background color of scaffold
        ),
        initialRoute: '/home',
        routes: {
          //'/on': (context) => OnboardingScreen(),
          '/signup': (context) => Signup(),
          '/home': (context) => HomePageWidget(),

          ''
              '/dashboard': (context) => Dashboard(
                isDark: false,
              ),
        });
  }
}
