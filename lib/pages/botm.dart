import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:ecommerce/pages/category.dart';
import 'package:ecommerce/pages/favorite.dart';
import 'package:ecommerce/pages/profile.dart';
import 'package:ecommerce/pages/search.dart';

import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

import 'home.dart';

const List<Widget> myllist = [
  Home(),
  Category(),
  Searchpage(),
  Favorite(),
  Profile(),
];
List<Widget> _buildScreens() {
  return const [
    Home(),
    Category(),
    Searchpage(),
    Favorite(),
    Profile(),
  ];
}

const List<TabItem> items = [
  TabItem(
    icon: Icons.home,
    // title: 'Home',
  ),
  TabItem(
    icon: Icons.search_sharp,
    // title: 'Shop',
  ),
  TabItem(
    icon: Icons.favorite_border,
    // title: 'Wishlist',
  ),
  TabItem(
    icon: Icons.shopping_cart_outlined,
    // title: 'Cart',
  ),
  TabItem(
    icon: Icons.account_box,

    // title: 'profile',
  ),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int visit = 0;
  double height = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // primary: Colors.green,
      body: Stack(children: [
        Offstage(
          /// Wrap Tab with OffStage
          offstage: visit != 0,
          child:  Home(),
        ),
        visit == 1
            ? const Category()
            : Offstage(
                offstage: visit != 2,
                child: const Searchpage(),
              ),
        visit == 3
            ? const Favorite()
            : Offstage(
                offstage: visit != 4,
                child: const Profile(),
              ),
        Offstage(child: myllist.elementAt(visit))
      ]),
      bottomNavigationBar: Container(
        height: 100,
        // padding: const EdgeInsets.only(bottom: 30, right: 32, left: 32),
        child: BottomBarInspiredFancy(
          paddingVertical: 1,
          items: items,
          borderRadius: BorderRadius.circular(50),
          backgroundColor: Colors.transparent,
          color: Colors.green,
          colorSelected: Colors.green,
          indexSelected: visit,
          styleIconFooter: StyleIconFooter.divider,
          onTap: (int index) => setState(() {
            visit = index;
          }),
        ),
      ),
    );
  }
}
