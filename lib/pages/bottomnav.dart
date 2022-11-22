import 'package:ecommerce/pages/category.dart';
import 'package:ecommerce/pages/favorite.dart';
import 'package:ecommerce/pages/home.dart';
import 'package:ecommerce/pages/profile.dart';
import 'package:ecommerce/pages/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

List<Widget> _buildScreens() {
  return const [
    Home(),
    Category(),
    Searchpage(),
    Favorite(),
    Profile(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: 'home',
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(IconData(0xe148, fontFamily: 'MaterialIcons')),
      title: ("cat"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.search,
        size: 35,
      ),
      title: ("sear"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite_border_rounded),
      title: ("fav"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.profile_circled),
      title: ("pro"),
      activeColorPrimary: CupertinoColors.activeGreen,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}

class BotmNav extends StatelessWidget {
  const BotmNav({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,

      navBarStyle:
          NavBarStyle.style13, // Choose the nav bar style with this property.
    );
  }
}
