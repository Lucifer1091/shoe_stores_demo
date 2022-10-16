import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:crony_interview/chips_group.dart';
import 'package:crony_interview/collection_card.dart';
import 'package:crony_interview/models.dart';
import 'package:crony_interview/shoe_card.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'constants.dart';
import 'color_scheme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var _bottomNavIndex = 0;

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  var iconsList = [
    'assets/icons/broken_home.png',
    'assets/icons/broken_search.png',
    'assets/icons/broken_heart.png',
    'assets/icons/broken_profile.png',
  ];

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(child: _buildAppBar(context)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 240,
                child: _buildHorizontalListView(context),
              ),
            ),
            SliverToBoxAdapter(child: _buildCategoryChips(context)),
            SliverFillRemaining(child: _buildNewCollections(context)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    (MediaQuery.of(context).size.height < 700 ? 0.2 : 0.05),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(Constants.kPaddingM),
          child: Image.asset('assets/icons/broken_buy.png'),
        ),
        onPressed: () {
          _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconsList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppColors.kPrimaryColor : Colors.white;
          return Padding(
            padding: const EdgeInsets.all(Constants.kPaddingM * 1.6),
            child: Image.asset(
              iconsList[index],
              color: color,
            ),
          );
        },
        backgroundColor: AppColors.kNavBarColor,
        activeIndex: _bottomNavIndex,
        notchAndCornersAnimation: borderRadiusAnimation,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        splashSpeedInMilliseconds: 300,
        splashColor: AppColors.kPrimaryColor,
        notchSmoothness: NotchSmoothness.smoothEdge,
        gapLocation: GapLocation.center,
        height: 75,
      ),
    );
  }

  Widget _buildNewCollections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Constants.kPaddingL * 0.8,
            right: Constants.kPaddingL * 0.8,
            top: Constants.kPaddingL,
            bottom: Constants.kPaddingS,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "News Collection' 22",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: AppColors.kTxtHeadingColor,
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
              ),
              const Spacer(),
              const Text(
                'View All',
                style: TextStyle(
                  color: AppColors.kTxtViewAllColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _buildGridView(context)),
      ],
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      padding: const EdgeInsets.only(
        top: Constants.kPaddingL,
        left: Constants.kPaddingM * .7,
        right: Constants.kPaddingM * .7,
      ),
      itemCount: gridViewItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Constants.kPaddingM * 1.5,
        childAspectRatio: 1.01,
      ),
      itemBuilder: (context, index) {
        return ShoeCollectionCard(shoe: gridViewItems[index]);
      },
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Constants.kPaddingL * 0.8,
            right: Constants.kPaddingL * 0.8,
            bottom: Constants.kPaddingM,
          ),
          child: Text(
            'Categories',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppColors.kTxtHeadingColor,
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
          ),
        ),
        const ChipsGroup(),
      ],
    );
  }

  Widget _buildHorizontalListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.kPaddingS),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listViewItems.length,
        itemBuilder: (context, index) {
          return ShoeCard(
            shoe: listViewItems[index],
            color: index % 2 != 0
                ? AppColors.kPrimaryColor
                : AppColors.kSecondaryColor,
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Constants.kPaddingL * 0.8,
        vertical: Constants.kPaddingS * 1.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/drawer_icon.png',
                height: 13,
              ),
              const Spacer(),
              Image.asset(
                'assets/icons/broken_notification.png',
                height: 25,
              ),
              const SizedBox(width: Constants.kPaddingM * 1.3),
              CircleAvatar(
                backgroundColor: AppColors.kPrimaryColor,
                radius: 26,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.kPaddingS / 2),
                  child: Image.asset(
                    'assets/icons/avatar.png',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Constants.kPaddingS / 2),
          Text(
            'Hi, Ali Aman',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: AppColors.kTxtHeadingColor,
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
          ),
        ],
      ),
    );
  }
}

// FluidNavBar(
// icons: [
// FluidNavBarIcon(
// svgPath: "assets/icons/broken_home.svg",
// backgroundColor: AppColors.kPrimaryColor,
// ),
// FluidNavBarIcon(
// svgPath: 'assets/icons/broken_search.svg',
// backgroundColor: AppColors.kNavBarColor,
// ),
// FluidNavBarIcon(
// svgPath: 'assets/icons/broken_buy.svg',
// backgroundColor: AppColors.kNavBarColor,
// ),
// FluidNavBarIcon(
// svgPath: "assets/icons/broken_heart.svg",
// backgroundColor: AppColors.kNavBarColor,
// ),
// FluidNavBarIcon(
// svgPath: "assets/icons/broken_profile.svg",
// backgroundColor: AppColors.kNavBarColor,
// ),
// ],
// style: const FluidNavBarStyle(
// iconUnselectedForegroundColor: Colors.white,
// iconSelectedForegroundColor: Colors.white,
// barBackgroundColor: AppColors.kNavBarColor,
// iconBackgroundColor: AppColors.kNavBarColor,
// ),
// scaleFactor: 1.5,
// defaultIndex: 1,
// ),
