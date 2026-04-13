import 'package:blogclub/gen/fonts.gen.dart';
import 'package:blogclub/home.dart';
import 'package:blogclub/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xff0D253C);
    const Color secondaryTextColor = Color(0xff2D4379);
    const Color primaryColor = Color(0xff376AED);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData(
          snackBarTheme: const SnackBarThemeData(backgroundColor: primaryColor),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: primaryTextColor,
            // This is the padding of appbar from edges
            titleSpacing: 32,
          ),
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              surface: Color(0xffFBFCFF),
              onSurface: primaryTextColor),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.avenir)))),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
                fontSize: 24),
            titleLarge: TextStyle(
                fontFamily: FontFamily.avenir,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
                fontSize: 18),
            titleMedium: TextStyle(
                fontFamily: FontFamily.avenir,
                color: secondaryTextColor,
                fontSize: 14),
            headlineSmall: TextStyle(
                fontFamily: FontFamily.avenir,
                color: primaryTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 20),
            titleSmall: TextStyle(
                fontFamily: FontFamily.avenir,
                color: primaryTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            bodySmall: TextStyle(
                fontFamily: FontFamily.avenir,
                color: Color(0xff7B8BB2),
                fontWeight: FontWeight.w700,
                fontSize: 10),
            bodyLarge: TextStyle(
                fontFamily: FontFamily.avenir,
                color: primaryTextColor,
                fontSize: 14),
          )),
      // home: Stack(
      //   children: [
      //     const Positioned.fill(child: HomeScreen()),
      //     Positioned(bottom: 0, right: 0, left: 0, child: BottomNavigation())
      //   ],
      // ),
      home: const ProfileScreen(),
    );
  }
}
