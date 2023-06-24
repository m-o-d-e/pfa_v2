import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sol_flow/pages/on_boarding/onboding_screen.dart';
import 'package:sol_flow/utlis/framwork_utils/internationalization.dart';
import '/pages/home_page/home_page_widget.dart';
import '/pages/dashboard/dashboard.dart';
import '/pages/sign_up/signup.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utlis/framwork_utils.dart';
import 'index.dart';
import '/pages/add_p_a_g_e/add_p_a_g_e_widget.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primaryColor: Colors.green, // the color of the app bar
//           accentColor: Colors.red, // the color used for buttons, etc.
//           backgroundColor: Colors.white, // the default background color
//           scaffoldBackgroundColor:
//               Colors.grey[200], // the background color of scaffold
//         ),
//         initialRoute: '/home',
//         routes: {
//           '/add': (context) => AddPAGEWidget(),
//           //'/on': (context) => OnboardingScreen(),
//           '/signup': (context) => Signup(),
//           '/home': (context) => HomePageWidget(),
//
//           ''
//               '/dashboard': (context) => Dashboard(
//                 isDark: false,
//               ),
//         });
//   }
// }
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await FlutterFlowTheme.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.light;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'solFlow',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
