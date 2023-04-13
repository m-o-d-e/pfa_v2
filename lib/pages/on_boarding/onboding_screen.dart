import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'walkthrough.dart';
import '../../animations/fade_animation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //Rive Animations related
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final isLargeOrLandscape = size.width > 600 ||
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          const RiveAnimation.asset("assets/rive_animations/shapes.riv"),
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Stack(
              children: [
                Image.asset("assets/Backgrounds/Spline.png"),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                    child: const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 320,
                    child: Column(
                      children: [
                        FadeAnimation(
                            1.4,
                            const Text(
                              "Cultiver avec confiance",
                              style: TextStyle(
                                fontSize: 55,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                            )),
                        //HandDrawnLine(),
                        const SizedBox(height: 16),
                        FadeAnimation(
                          1.4,
                          const Text(
                            "Optimisez votre production agricole grâce à notre système intelligent d'irrigation et prenez des décisions éclairées en toute confiance pour votre exploitation.",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  InkWell(
                    onTap: () async {
                      _btnAnimationController.isActive = true;
                      await Future.delayed(const Duration(milliseconds: 900));
                      navigateToNextScreen(context);
                    },
                    child: SizedBox(
                      height: 64,
                      width: 260,
                      child: FadeAnimation(
                        2,
                        Stack(
                          children: [
                            FadeAnimation(
                                2,
                                RiveAnimation.asset(
                                  "assets/rive_animations/button.riv",
                                  controllers: [_btnAnimationController],
                                )),
                            Positioned.fill(
                              top: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(CupertinoIcons.arrow_right,
                                      color: Colors.black),
                                  SizedBox(width: 8),
                                  Text(
                                    "Commencer",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black,
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
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: FadeAnimation(
                        2.3,
                        const Text(
                            "⚠ Les informations fournies par cette application sont destinées à titre informatif uniquement. Elles ne doivent pas être utilisées pour prendre des décisions critiques sans consulter un expert en la matière",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            )),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: const WalkthroughPage(),
        ),
      ),
    );
  }
}
