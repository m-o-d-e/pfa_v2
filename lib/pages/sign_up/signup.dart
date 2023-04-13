import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../animations/fade_animation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool checkedValue = false;
  bool register = true;

  List textfieldsStrings = [
    "", //firstName
    "", //lastName
    "", //phoneNumber
    "", //email
    "", //password
    "", //confirmPassword
  ];

  final _firstnamekey = GlobalKey<FormState>();
  final _lastNamekey = GlobalKey<FormState>();
  final _phoneNumberkey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _confirmPasswordKey = GlobalKey<FormState>();

  bool _isLoading = false;
  ButtonState stateTextWithIcon = ButtonState.idle;

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
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
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
                            'Bienvenue,',
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
                            child: Text(
                          'Créez votre compte',
                          style: GoogleFonts.poppins(
                            color: isDarkMode
                                ? Colors.white
                                : const Color(0xff1D1617),
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Column(
                        children: [
                          buildTextField(
                            "Prénom",
                            Icons.person_outlined,
                            false,
                            size,
                            (valuename) {
                              if (valuename.length <= 2) {
                                buildSnackError(
                                    'Le prénom doit contenir au moins 3 caractères',
                                    context,
                                    size,
                                    isDarkMode);
                                return '';
                              }
                              return null;
                            },
                            _firstnamekey,
                            0,
                            isDarkMode,
                          ),
                          buildTextField(
                            "Nom",
                            Icons.person_outlined,
                            false,
                            size,
                            (valuesurname) {
                              if (valuesurname.length <= 2) {
                                buildSnackError(
                                    'Le nom doit contenir au moins 3 caractères',
                                    context,
                                    size,
                                    isDarkMode);
                                return '';
                              }
                              return null;
                            },
                            _lastNamekey,
                            1,
                            isDarkMode,
                          ),
                          Form(
                            child: buildTextField(
                              "Email",
                              Icons.email_outlined,
                              false,
                              size,
                              (valuemail) {
                                if (valuemail.length < 5) {
                                  buildSnackError(
                                      'l\'email doit contenir au moins 6 caractères',
                                      context,
                                      size,
                                      isDarkMode);
                                  return '';
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                    .hasMatch(valuemail)) {
                                  buildSnackError('l\'email est invalide',
                                      context, size, isDarkMode);
                                  return '';
                                }
                                return null;
                              },
                              _emailKey,
                              2,
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
                                      'Mot de passe invalide, minimum 6 caractères',
                                      context,
                                      size,
                                      isDarkMode);
                                  return '';
                                }
                                return null;
                              },
                              _passwordKey,
                              3,
                              isDarkMode,
                            ),
                          ),
                          Form(
                              child: buildTextField(
                            "Confirmer le mot de passe",
                            Icons.lock_outline,
                            true,
                            size,
                            (valuepassword) {
                              if (valuepassword != textfieldsStrings[3]) {
                                buildSnackError(
                                    'Les mots de passe ne correspondent pas',
                                    context,
                                    size,
                                    isDarkMode);
                                return '';
                              }
                              return null;
                            },
                            _confirmPasswordKey,
                            4,
                            isDarkMode,
                          )),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.015,
                            vertical: size.height * 0.025,
                          ),
                          child: CheckboxListTile(
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "En vous inscrivant, vous acceptez nos ",
                                    style: TextStyle(
                                      color: const Color(0xffADA4A5),
                                      fontSize: size.height * 0.015,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () {
                                        print('Conditions d\'utilisation');
                                      },
                                      child: Text(
                                        "Conditions d\'utilisation",
                                        style: TextStyle(
                                          color: const Color(0xffADA4A5),
                                          decoration: TextDecoration.underline,
                                          fontSize: size.height * 0.015,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: " et ",
                                    style: TextStyle(
                                      color: const Color(0xffADA4A5),
                                      fontSize: size.height * 0.015,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: InkWell(
                                      onTap: () {
                                        print(
                                            'nos Politiques de confidentialité');
                                      },
                                      child: Text(
                                        "nos Politiques de confidentialité",
                                        style: TextStyle(
                                          color: const Color(0xffADA4A5),
                                          decoration: TextDecoration.underline,
                                          fontSize: size.height * 0.015,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            activeColor: const Color(0xff7B6F72),
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          )),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: ProgressButton.icon(
                          iconedButtons: {
                            ButtonState.idle: const IconedButton(
                              text: "S'inscrire",
                              icon: Icon(Icons.lock, color: Colors.white),
                              color: Color(0xFF4CAF50),
                            ),
                            ButtonState.loading: const IconedButton(
                              text: "Inscription en cours",
                              color: Color(0xFF4CAF50),
                            ),
                            ButtonState.fail: IconedButton(
                              text: "Echec",
                              icon:
                                  const Icon(Icons.cancel, color: Colors.white),
                              color: Colors.red.shade300,
                            ),
                            ButtonState.success: IconedButton(
                              text: "Succès",
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              color: Colors.green.shade400,
                            ),
                          },
                          onPressed: () async {},
                          state: stateTextWithIcon,
                          minWidth: size.width * 0.8,
                          maxWidth: size.width * 0.8,
                          radius: 10.0,
                        ),
                      ),
                      AnimatedPadding(
                          duration: const Duration(milliseconds: 500),
                          padding: EdgeInsets.only(top: size.height * 0.025),
                          child: FadeAnimation(
                            1.7,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Eau',
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
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
                          )),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Vous avez déjà un compte? ",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xff1D1617),
                                fontSize: size.height * 0.018,
                              ),
                            ),
                            WidgetSpan(
                              child: InkWell(
                                  onTap: () =>
                                      //navigate to login page
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      ),
                                  child: Text(
                                    "Se connecter",
                                    style: TextStyle(
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: <Color>[
                                            Color(0xFF4CAF50),
                                            Color(0xFF4CAF50),
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(
                                            0.0,
                                            0.0,
                                            200.0,
                                            70.0,
                                          ),
                                        ),
                                      fontSize: size.height * 0.018,
                                    ),
                                  )),
                            ),
                          ],
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
    int stringToEdit,
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
                textfieldsStrings[stringToEdit] = value;
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
      String error, context, size, bool isDarkMode) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(
              error,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
