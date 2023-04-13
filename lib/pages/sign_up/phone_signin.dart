import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'login.dart';
import '../../constants.dart';
import '../../exceptions/form_exceptions.dart';

class PhoneSignin extends StatefulWidget {
  const PhoneSignin();

  @override
  _PhoneSignin createState() => _PhoneSignin();
}

class _PhoneSignin extends State<PhoneSignin> {
  TextEditingController controller = TextEditingController();
  bool isValid = false;
  ButtonState stateTextWithIcon = ButtonState.idle;
  final _phoneNumberKey = GlobalKey<FormState>();
  String phoneNumber = '';
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.addListener(() {
      setState(() {
        String inputValue = controller.text
            .replaceAll(' ', ''); // Remove spaces from the input value
        isValid = inputValue.length ==
            10; // Update the validity based on the length of the input
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
        reverse: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/verify.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: const Color(0xff1D1617),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Veuillez entrer votre numéro de téléphone, nous vous enverrons un code de vérification par SMS.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Form(
                          child: TextFormField(
                            key: _phoneNumberKey,
                            keyboardType: TextInputType.number,
                            controller: controller,
                            onChanged: (value) {
                              setState(() {
                                phoneNumber = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                buildSnackError(
                                    'Le numéro de téléphone est obligatoire',
                                    context,
                                    size,
                                    false);
                              }
                              if (value.length < 10) {
                                buildSnackError(
                                    'Le numéro de téléphone doit contenir 10 chiffres',
                                    context,
                                    size,
                                    false);
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: const TextStyle(
                              fontSize: 18,
                              color: const Color(0xff1D1617),
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10)),
                              prefix: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '(+212)',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff1D1617),
                                  ),
                                ),
                              ),
                              suffixIcon: isValid
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      // Add padding to the right of the container
                                      child: Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16.0,
                                        ),
                                      ),
                                    )
                                  : null,
                              suffixIconConstraints: const BoxConstraints(
                                  minHeight: 24, minWidth: 24),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ProgressButton.icon(
                            iconedButtons: {
                              ButtonState.idle: const IconedButton(
                                text: "Envoyer",
                                icon: Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                    color: Colors.white),
                                color: Color(0xFF4CAF50),
                              ),
                              ButtonState.loading: const IconedButton(
                                text: "Inscription en cours",
                                color: Color(0xFF4CAF50),
                              ),
                              ButtonState.fail: IconedButton(
                                text: "Echec",
                                icon: const Icon(Icons.cancel,
                                    color: Colors.white),
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

                        //vous voulez continuer par email?
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous voulez continuer par email?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      child: const Text(
                        "Cliquez ici",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
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
