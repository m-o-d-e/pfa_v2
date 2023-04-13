import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'dart:math';

class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({Key? key}) : super(key: key);

  @override
  State<WalkthroughPage> createState() => _walkthroughPage();
}

class _walkthroughPage extends State<WalkthroughPage> {
  // page related
  final PageController _controller = PageController(initialPage: 0);
  int pageIndex = 0;
  String titleText = "Programmez votre \nirrigation";
  String descriptionText =
      "Planifiez votre irrigationà l'avance pour\néconomiser de l'eau et améliorer votre rendement";

  double animatedPositionWaveImageLeft = 40;

  // page change funciton
  updatePage(int nextIndex) {
    setState(() {
      pageIndex = nextIndex;

      if (nextIndex == 0) {
        titleText = "Programmez votre \nirrigation";
        descriptionText =
            "Planifiez votre irrigationà l'avance pour\néconomiser de l'eau et améliorer votre rendement";
        animatedPositionWaveImageLeft = 40;
      } else if (nextIndex == 1) {
        titleText = "Restez informé";
        descriptionText =
            "Recevez des notifications pour irriguer vos cultures \nau bon moment et éviter les gaspillages";
        animatedPositionWaveImageLeft = -350;
      } else {
        titleText = "Economisez de l'eau";
        descriptionText =
            "Optimisez votre consommation d'eau en utilisant notre \nsolution d'irrigation intelligente et économe";
        animatedPositionWaveImageLeft = -750;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // context related
    final ThemeData themeData = Theme.of(context);
    final Size ds = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // top dark mode and skip button
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                // width: ds.width,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.sun_max_fill,
                        color: Colors.amber[600],
                      ),
                    ),
                    Text(
                      "Mode Clair",
                      style: themeData.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: pageIndex != 2
                          ? GestureDetector(
                              onTap: () {
                                _controller.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  "Passer",
                                  style:
                                      themeData.textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // background wave image
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            left: animatedPositionWaveImageLeft,
            child: Image.asset(
              'assets/shapes/wh.png',
              fit: BoxFit.cover,
              // width: 3000,
            ),
          ),
          // vector image on center
          SizedBox(
            height: 600,
            child: PageView.custom(
              onPageChanged: (nextIndex) {
                updatePage(nextIndex);
              },
              controller: _controller,
              childrenDelegate: SliverChildBuilderDelegate(
                ((BuildContext context, int index) {
                  return AnimatedBuilder(
                    animation: const AlwaysStoppedAnimation(0),
                    builder: (BuildContext context, Widget? child) {
                      final double offset = 10 *
                          sin(2 *
                              pi *
                              DateTime.now().millisecondsSinceEpoch /
                              1000);
                      return Transform.translate(
                        offset: Offset(0, offset),
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'assets/images/v$index.png',
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                  );
                }),
                childCount: 3,
              ),
            ),
          ),

          // page indicators
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: ds.height * 0.05,
              ),
              child: SizedBox(
                width: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // dynamically generate using a list!

                  children: List<Widget>.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      // we are going to set the height and width of the container based on the page index
                      // this is going to be covered in the animation section / chapter
                      height: pageIndex == index ? 15 : 10,
                      width: pageIndex == index ? 25 : 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: pageIndex == index
                            ? themeData.colorScheme.surface
                            : themeData.colorScheme.outline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // titles
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            bottom: pageIndex == 1 ? ds.height / 1.4 : ds.height / 7,
            child: SizedBox(
              width: ds.width,
              child: Padding(
                padding: EdgeInsets.only(left: ds.width * 0.09),
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  children: [
                    Text(
                      titleText,
                      style: themeData.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      descriptionText,
                      style: themeData.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // start button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: ds.width * 0.05,
                bottom: ds.height * 0.03,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: pageIndex == 2
                    ? FloatingActionButton(
                        backgroundColor: themeData.colorScheme.surface,
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const Signup(),
                          //   ),
                          // );
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
