import 'dart:ui';

import 'package:blogclub/carousel/carousel_slider.dart';
import 'package:blogclub/data.dart';
import 'package:flutter/cupertino.dart';
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
    final Color primaryColor = Color(0xff376AED);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: defaultFontFamily)))),
          textTheme: TextTheme(
            displayLarge: TextStyle(
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
                fontSize: 24),
            titleLarge: TextStyle(
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.bold,
                color: primaryTextColor,
                fontSize: 18),
            titleMedium: TextStyle(
                fontFamily: defaultFontFamily,
                color: secondaryTextColor,
                fontSize: 14),
            headlineSmall: TextStyle(
                fontFamily: defaultFontFamily,
                color: primaryTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 20),
            titleSmall: TextStyle(
                fontFamily: defaultFontFamily,
                color: primaryTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          )),
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
          physics: const BouncingScrollPhysics(),
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
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            StoryList(stories: stories),
            const SizedBox(
              height: 16,
            ),
            const CategoryList(),
            const SizedBox(
              height: 12,
            ),
            PostList(),
            const SizedBox(
              height: 32,
            )
          ]),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;
    return CarouselSlider.builder(
        itemCount: categories.length,
        itemBuilder: (context, index, realIndex) {
          return CategoryItem(
            left: realIndex == 0 ? 32 : 8,
            right: realIndex == categories.length - 1 ? 32 : 8,
            category: categories[realIndex],
          );
        },
        options: CarouselOptions(
          scrollDirection: Axis.horizontal, // Main Axis of slider
          viewportFraction: 0.8, // How much of page will be got
          // We can set the ratio of each image
          // If we set it 1, each item is a rectangle
          aspectRatio: 1.2,
          initialPage: 0,
          disableCenter: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
        ));
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;
  final double left;
  final double right;
  const CategoryItem({
    Key? key,
    required this.category,
    required this.left,
    required this.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            top: 100,
            right: 65,
            left: 65,
            bottom: 24,
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 20, color: Color(0xaa0D253C))
              ]),
            )),
        Positioned.fill(
          left: left,
          right: right,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
            ),
            foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Color(0xff0D253C),
                      Colors.transparent,
                    ])),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/img/posts/large/${category.imageFileName}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 48,
          left: 42,
          child: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .apply(color: Colors.white),
          ),
        )
      ],
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

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final posts = AppDatabase.posts;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Latest News',
                  style: Theme.of(context).textTheme.headlineSmall),
              TextButton(onPressed: () {}, child: const Text('More'))
            ],
          ),
        ),
        ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: posts.length,
            itemExtent: 141, // We should set the itme height
            shrinkWrap: true, // Set the list height depends on item height
            itemBuilder: (context, index) {
              final post = posts[index];
              return Post(post: post);
            })
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostData post;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 149,
      margin: const EdgeInsets.fromLTRB(32, 8, 32, 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(blurRadius: 10, color: Color(0x1a5282FF))
          ]),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:
                  Image.asset('assets/img/posts/small/${post.imageFileName}')),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.caption,
                  style: const TextStyle(
                      fontFamily: MyApp.defaultFontFamily,
                      color: Color(0xff376AED),
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      CupertinoIcons.hand_thumbsup,
                      size: 16,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      post.likes,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Icon(
                      CupertinoIcons.clock,
                      size: 16,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      post.time,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Expanded(
                        child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        post.isBookmarked
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        size: 16,
                        color: post.isBookmarked
                            ? Colors.blueAccent
                            : Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
