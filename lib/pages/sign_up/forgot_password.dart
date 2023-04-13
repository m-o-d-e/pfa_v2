import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../animations/fade_animation.dart';
import '../../widgets/button_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = '';

  final _emailKey = GlobalKey<FormState>();

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
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () =>
                                  Navigator.pop(context),
                            child: Icon(
                                Icons.arrow_back,
                                color: isDarkMode ? Colors.white : Colors.black,
                                size: size.height * 0.03,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.015,
                                vertical: size.height * 0.03,
                              ),
                              child: Text(
                                'Retour',
                                style: GoogleFonts.poppins(
                                  color: isDarkMode
                                      ? Colors.white
                                      : const Color(0xff1D1617),
                                  fontSize: size.height * 0.018,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                     FadeAnimation(1.5,
                         Padding(
                           padding: EdgeInsets.only(
                             top: size.height * 0.05,
                             left: size.width * 0.055,
                           ),
                           child: Align(
                             alignment: Alignment.centerLeft,
                             child: Text(
                               'Mot de passe oublié',
                               style: GoogleFonts.poppins(
                                 color: isDarkMode
                                     ? Colors.white
                                     : const Color(0xff1D1617),
                                 fontSize: size.height * 0.035,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                           ),
                         )),
                    FadeAnimation(1.5,
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.055),
                        child: Align(
                          child: Text(
                            "Entrez votre adresse e-mail et nous vous enverrons des instructions pour réinitialiser votre mot de passe",
                            style: GoogleFonts.poppins(
                              color:
                              isDarkMode ? Colors.white54 : Colors.black54,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      ),),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      FadeAnimation(1.5,
                        Form(
                          child: buildTextField(
                            "Email",
                            Icons.email_outlined,
                            false,
                            size,
                                (valuemail) {
                              if (valuemail.length < 5) {
                                buildSnackError(
                                  'l\'email est trop court',
                                  context,
                                  size,
                                );
                                return '';
                              }
                              if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                  .hasMatch(valuemail)) {
                                buildSnackError(
                                  'l\'email est invalide',
                                  context,
                                  size,
                                );
                                return '';
                              }
                              return null;
                            },
                            isDarkMode,
                          ),
                        ),),
                        FadeAnimation(1.6,
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.025),
                            child: ButtonWidget(
                                text: 'Envoyer',
                                backColor:const [Color(0xFF4BC04B), Color(0xFF4CAF50)],
                                textColor: const [
                                  Colors.white,
                                  Colors.white,
                                ],
                                onPressed: () async {
                                  if (_emailKey.currentState!.validate()) {
                                  }
                                }),
                          ),),
                          FadeAnimation(1.7,
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.08),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Eau',
                                    style: GoogleFonts.poppins(
                                      color: isDarkMode ? Colors.white : Colors
                                          .black,
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
                            ),),
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
      bool isDarkMode,
      ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Form(
          key: _emailKey,
          child: TextFormField(
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                email = value;
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