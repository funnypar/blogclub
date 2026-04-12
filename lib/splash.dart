import 'package:blogclub/gen/assets.gen.dart';
import 'package:blogclub/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((val) => {
          // We also have CupertionPageRoute and this is just animation to change the route
          Navigator.of(context)
              // When we use "push" we can hit the back button and go to splash again and we do not want that
              .pushReplacement(CupertinoPageRoute(builder: (context) {
            return const OnBoardingScreen();
          }))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
            child: Assets.img.background.splash.image(fit: BoxFit.cover)),
        Center(child: Assets.img.icons.logo.svg(width: 100))
      ]),
    );
  }
}
