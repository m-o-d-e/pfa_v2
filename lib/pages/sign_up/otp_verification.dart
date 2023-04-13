import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../animations/fade_animation.dart';
import '../../constants.dart';
import '../../widgets/button_widget.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  _OtpVerificationPage createState() => _OtpVerificationPage();
}

class _OtpVerificationPage extends State<OtpVerificationPage> {
  String email = '';
  String phoneNumber = '2345T6543';
  String otp = '';
  int _counter = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

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
                        FadeAnimation(1.5,
                            Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.05,
                                left: size.width * 0.055,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Vérifier votre numéro',
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
                                "Nous avons envoyé un code de vérification à $phoneNumber, veuillez le saisir ci-dessous",
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width:70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                        color: isDarkMode ? Colors.black :  Colors.redAccent.withOpacity(0),
                                      ),

                                    ),
                                    child: Form(
                                      child: TextFormField(
                                        onChanged: (value){
                                          if(value.length == 1){
                                            FocusScope.of(context).nextFocus();
                                          }
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            otp = value!;
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,

                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(1),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        style: TextStyle(
                                            color: isDarkMode ? const Color(0xffADA4A5) : Colors.black ),
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                            hintText: "0",

                                          hintStyle: TextStyle(
                                            color: Color(0xffADA4A5),
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),

                                        ),

                                      ),
                                    ),
                                  ),
                                Container(
                                  width:70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.black :  Colors.redAccent.withOpacity(0),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Form(
                                    child: TextFormField(
                                      onChanged: (value){
                                        if(value.length == 1){
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          otp = value!;
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      style: TextStyle(
                                          color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
                                      textInputAction: TextInputAction.next,
                                      decoration:  const InputDecoration(
                                        hintText: "0",
                                        errorStyle: TextStyle(height: 0),
                                        hintStyle: TextStyle(
                                          color: Color(0xffADA4A5),
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.black :  Colors.redAccent.withOpacity(0),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Form(
                                    child: TextFormField(
                                      onChanged: (value){
                                        if(value.length == 1){
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          otp = value!;
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      style: TextStyle(
                                          color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        hintText: "0",
                                        errorStyle: TextStyle(height: 0),
                                        hintStyle: TextStyle(
                                          color: Color(0xffADA4A5),
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),

                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.black :  Colors.redAccent.withOpacity(0),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Form(
                                    child: TextFormField(
                                      onChanged: (value){
                                        if(value.length == 1){
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          otp = value!;
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      style: TextStyle(
                                          color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        hintText: "0",
                                        errorStyle: TextStyle(height: 0),
                                        hintStyle: TextStyle(
                                          color: Color(0xffADA4A5),
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),),

                        FadeAnimation(1.6,
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.1),
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: ButtonWidget(
                                            text: 'Continuer',
                                            backColor: const [Color(0xFF4BC04B), Color(0xFF4CAF50)],
                                            textColor: const [
                                              Colors.white,
                                              Colors.white,
                                            ],
                                            onPressed: () async {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ),),
                        FadeAnimation(1.7,
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height * 0.1, horizontal: size.width * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children:  [
                                    const Icon(Icons.timer),
                                    Text('$_counter secondes restantes', style: const TextStyle(fontSize: 12),),
                                  ],
                                ),
                                OutlinedButton(
                                  onPressed: _counter > 0 ? null : () {
                                    setState(() {
                                      _counter = 60;
                                    });
                                    _startTimer();
                                  },

                                  child: Text('Renvoyer le code', style: TextStyle(color:_counter == 0? kSecondaryColor : Colors.grey),),
                                ),
                              ],
                            ),
                          ),

                        ),
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