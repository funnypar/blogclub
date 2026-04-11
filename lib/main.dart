import 'dart:ui';

import 'package:blogclub/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const defaultFontFamily = 'Avenir';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryTextColor = Color(0xff0D253C);
    final Color secondaryTextColor = Color(0xff2D4379);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: TextTheme(
              titleLarge: TextStyle(
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor),
              titleMedium: TextStyle(
                  fontFamily: defaultFontFamily,
                  color: secondaryTextColor,
                  fontSize: 14))),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stories = AppDatabase.stories;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, Jonathon!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Image.asset(
                    'assets/img/icons/notification.png',
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 24),
              child: Text(
                'Explore today’s',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            StoryList(stories: stories)
          ]),
        ),
      ),
    );
  }
}

class StoryList extends StatelessWidget {
  const StoryList({
    Key? key,
    required this.stories,
  }) : super(key: key);

  final List<StoryData> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: stories.length, // We should set it
          scrollDirection: Axis.horizontal, // the axis of the list
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          itemBuilder: (context, index) {
            final story = stories[index];

            return Story(story: story);
          }),
    );
  }
}

class Story extends StatelessWidget {
  const Story({
    Key? key,
    required this.story,
  }) : super(key: key);

  final StoryData story;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Column(
        children: [
          Stack(
            children: [
              _profileImageNormal(),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  width: 24,
                  height: 24,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(story.name)
        ],
      ),
    );
  }

  Container _profileImageNormal() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
            Color(0xff376AED),
            Color(0xff49B0E2),
            Color(0xff9CECFB),
          ])),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
        padding: const EdgeInsets.all(5),
        child: _profileImage(),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset('assets/img/stories/${story.imageFileName}'),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
