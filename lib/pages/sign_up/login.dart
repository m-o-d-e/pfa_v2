import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signup.dart';
import '../../animations/fade_animation.dart';
import '../../exceptions/form_exceptions.dart';

import '../../widgets/button_widget.dart';

import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool checkedValue = false;
  String _email = '';
  String _password = '';

  bool _isLoading = false;

  void updateEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  void updatePassword(String password) {
    setState(() {
      _password = password;
    });
  }

  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff151f2c) : Colors.white,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Align(
                          child: Text(
                            'Heureux de vous revoir,',
                            style: GoogleFonts.poppins(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: Align(
                            child: FadeAnimation(
                          1.5,
                          Text(
                            'Connectez-vous',
                            style: GoogleFonts.poppins(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      Container(),
                      Container(),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      FadeAnimation(
                        1.5,
                        Column(
                          children: [
                            Form(
                              child: buildTextField(
                                "Email",
                                Icons.email_outlined,
                                false,
                                size,
                                (valuemail) {
                                  if (valuemail.length < 5) {
                                    buildSnackError(
                                      'l\'email doit contenir au moins 5 caractères',
                                      context,
                                      size,
                                    );
                                    return '';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                      .hasMatch(valuemail)) {
                                    buildSnackError(
                                      'adresse email invalide',
                                      context,
                                      size,
                                    );
                                    return '';
                                  }
                                  return null;
                                },
                                _emailKey,
                                isDarkMode,
                              ),
                            ),
                            Form(
                              child: buildTextField(
                                "Mot de passe",
                                Icons.lock_outline,
                                true,
                                size,
                                (valuepassword) {
                                  if (valuepassword.length < 6) {
                                    buildSnackError(
                                      'le mot de passe doit contenir au moins 6 caractères',
                                      context,
                                      size,
                                    );
                                    return '';
                                  }
                                  return null;
                                },
                                _passwordKey,
                                isDarkMode,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.015,
                          vertical: size.height * 0.025,
                        ),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()),
                              );
                            },
                            child: FadeAnimation(
                              1.6,
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordPage()),
                                  );
                                },
                                child: Text(
                                  "Mot de passe oublié",
                                  style: TextStyle(
                                    color: const Color(0xffADA4A5),
                                    decoration: TextDecoration.underline,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      AnimatedPadding(
                          duration: const Duration(milliseconds: 500),
                          padding: EdgeInsets.only(top: size.height * 0.085),
                          child: _isLoading
                              ? const SpinKitDoubleBounce(
                                  color: Color(0xFF4CAF50),
                                  size: 50.0,
                                )
                              : FadeAnimation(
                                  1.7,
                                  ButtonWidget(
                                    text: "Connexion",
                                    backColor: const [
                                      Color(0xFF4BC04B),
                                      Color(0xFF4CAF50)
                                    ],
                                    textColor: const [
                                      Colors.white,
                                      Colors.white,
                                    ],
                                    onPressed: () async {
                                      //validation for login
                                    },
                                  ),
                                )),
                      FadeAnimation(
                        1.7,
                        AnimatedPadding(
                          duration: const Duration(milliseconds: 500),
                          padding: EdgeInsets.only(
                            top: size.height * 0.15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Eau',
                                style: GoogleFonts.poppins(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: size.height * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Wise',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF4CAF50),
                                  fontSize: size.height * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.7,
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Vous n'avez pas de compte?",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff1D1617),
                                  fontSize: size.height * 0.018,
                                ),
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () => setState(() {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Signup()),
                                    );
                                  }),
                                  child: Text(
                                    " Inscrivez-vous",
                                    style: TextStyle(
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF4CAF50),
                                            Color(0xFF4CAF50),
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(
                                              0.0, 0.0, 200.0, 70.0),
                                        ),
                                      // color: const Color(0xffC58BF2),
                                      fontSize: size.height * 0.018,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool pwVisible = false;

  Widget buildTextField(
    String hintText,
    IconData icon,
    bool password,
    size,
    FormFieldValidator validator,
    Key key,
    bool isDarkMode,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: TextFormField(
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                if (key == _emailKey) {
                  _email = value;
                } else if (key == _passwordKey) {
                  _password = value;
                }
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.02,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
              suffixIcon: password
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pwVisible = !pwVisible;
                          });
                        },
                        child: pwVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Color(0xff7B6F72),
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                color: Color(0xff7B6F72),
                              ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
}
