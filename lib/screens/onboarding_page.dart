import 'package:edu_vista/utils/color_utilis.dart';
import 'package:edu_vista/widgets/onboarding/elevated_button_rounded.dart';
import 'package:edu_vista/widgets/onboarding/onboard_indicator.dart';
import 'package:edu_vista/utils/image_utility.dart';
import 'package:edu_vista/widgets/onboarding/onboard_item_widget.dart';
import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart'

class OnBoardingpage extends StatefulWidget {
  static String id = 'OnBoardingpage';
  @override
  _OnBoardingpageState createState() => _OnBoardingpageState();
}

class _OnBoardingpageState extends State<OnBoardingpage> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: onChangedFunction,
            children: const <Widget>[
              OnBoardItemWidget(
                title: 'Certification and Badges',
                image: ImageUtility.badges,
                description:
                    'Earn a certificate after completion of every course',
              ),
              OnBoardItemWidget(
                title: 'Progress Tracking',
                image: ImageUtility.progresTraking,
                description: 'Check your Progress of every course',
              ),
              OnBoardItemWidget(
                title: 'Of f line Acc ess',
                image: ImageUtility.offLine,
                description: 'Of f line Acc ess',
              ),
              OnBoardItemWidget(
                title: 'Course Catalog',
                image: ImageUtility.curseCategory,
                description: 'View in which courses you are enrolled',
              ),
            ],
          ),
          Positioned(
            bottom: 200,
            left: 110,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                OnBoardIndicator(
                  positionIndex: 0,
                  currentIndex: currentIndex,
                ),
                const SizedBox(
                  width: 10,
                ),
                OnBoardIndicator(
                  positionIndex: 1,
                  currentIndex: currentIndex,
                ),
                const SizedBox(
                  width: 10,
                ),
                OnBoardIndicator(
                  positionIndex: 2,
                  currentIndex: currentIndex,
                ),
                const SizedBox(
                  width: 10,
                ),
                OnBoardIndicator(
                  positionIndex: 3,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            right: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                // mainAxisSize: MainAxisSize.max,

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  currentIndex == 3
                      ? const Text('')
                      : ElevatedButtonRounded(
                          onPressed: () {
                            nextFunction();
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 30,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            ColorUtility.deepYellow,
                          ),
                        )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                child: Row(
                  // mainAxisSize: MainAxisSize.max,

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    currentIndex == 0
                        ? const Text('')
                        : ElevatedButtonRounded(
                            onPressed: () {
                              previousFunction();
                            },
                            icon: const Icon(Icons.arrow_back,
                              size: 30,
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              ColorUtility.grayLight,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 30,
            child: TextButton(
                onPressed: () {
                  skipFunction(3);
                },
                child: currentIndex == 3
                    ? const Text('')
                    : const Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )),
          ),
        ],
      ),
    );
  }

  nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  skipFunction(int index) {
    _pageController.jumpToPage(index);
  }
}
