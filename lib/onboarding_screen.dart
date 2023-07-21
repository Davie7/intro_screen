import 'package:dope_intro_app/home_screen.dart';
import 'package:dope_intro_app/intro_screens/intro_screen1.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_screens/intro_screen2.dart';
import 'intro_screens/intro_screen3.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // controller to keep track of what page user is on
  final PageController _controller = PageController();
  // keep track if we are in the last page or not
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // pageview
        PageView(
          controller: _controller,
          onPageChanged: (index){
            // set the onLastPage  boolean to true if the index is equal to 2 i.e (last page)
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            IntroScreen1(),
            IntroScreen2(),
            IntroScreen3(),
          ],
        ),

        Container(
          alignment: Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // skip
              GestureDetector(onTap: () {
                    _controller.jumpToPage(2);
                  },child: Text('Skip')),
              // dot indicators
              SmoothPageIndicator(controller: _controller, count: 3),
              // next or done
              onLastPage?
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen()));
                  },
                  child: Text('Done')): GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Text('Next')),
            ],
          ),
        )
      ],
    ));
  }
}
